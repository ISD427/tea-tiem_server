class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/friend_list.json
    # params: user_id
    # カフェ内にいる異性を検索
    def friend_list
        user = User.find(params[:user_id])
        @cafename = user.status.cafename
        tsex = (user.sex == "Male") ? "Female" : "Male"

        # カフェ内にいる異性のid配列を取得
        friend_ids = Status.joins(:user).where("cafename = :cafename AND status = 'IN' AND users.sex = :sex", cafename: @cafename, sex: tsex).where.not(user_id: user.id).pluck(:user_id)

        # カフェ内にいる異性との関係を更新する
        update_friendships(user.id, friend_ids, @cafename)

        # カフェ内にいる異性との関係性を取得
        @friendships = Friendship.where(source_id: user.id, target_id: friend_ids)
    end

    # GET /places/place.json
    # params: user_id, location(latitude, longtitude)
    # 現在地情報を受け取り，カフェにいるかどうかを判定する
    def place
        # == 準備
        user_id = params[:user_id].nil? ? "user01" : params[:user_id]
        location = params[:location].nil? ? "35.004982,135.765843" : params[:location]
        currcafe = fetchPlace(location, "cafe") # APIからカフェを取得
        @st = Status.find_by(user_id: user_id) # ステータスデータ

        # 現在地がカフェの場合
        if !currcafe.empty? then
            case @st.status
            when "OUT" then
                @msg = currcafe['name'] + "にチェックインしています"
                @st.update(cafename: currcafe['name'], status: "WAITING")
            when "WAITING" then
                if @st.cafename == currcafe['name'] then
                    @msg = "現在" + currcafe['name'] + "にいます"
                    checkin(user_id, currcafe['name'])
                    @st.update(status: "IN")
                else
                    @msg = currcafe['name'] + "にチェックインしています"
                    @st.update(cafename: currcafe['name'], status: "WAITING")
                end
            when "IN" then
                if @st.cafename == currcafe['name'] then
                    @msg = "現在" + currcafe['name'] + "にいます"
                else
                    @msg = currcafe['name'] + "にチェックインしています"
                    checkout(user_id, @st.cafename)
                    @st.update(cafename: currcafe['name'], status: "WAITING")
                end
            end
        # 現在地がカフェでない場合
        else
            case @st.status
            when "OUT" then
                @msg = "近くにカフェがありません"
            when "WAITING" then
                @msg = "近くにカフェがありません"
                @st.update(cafename: nil, status: "OUT")
            when "IN" then
                @msg = "近くにカフェがありません"
                checkout(user_id, @st.cafename)
                @st.update(cafename: nil, status: "OUT")
            end
        end
    end

    private
        # params: uri, params
        # return string
        # uriとパラメータからリクエストURIを作成
        def makeUri (uri, params)
            first = true
            uristr = uri
            params.each{|key, val|
                if first then
                    uristr << "?" + key.to_s + "=" + val.to_s
                    first = false
                else 
                    uristr << "&" + key.to_s + "=" + val.to_s
                end
            }
            return uristr
        end

        # params: location, types
        # return: hashオブジェクト
        # Google Places APIを用いて1つの場所オブジェクトを取得
        def fetchPlace (location, types)
            # APIリクエストの作成
            cond = {
                radius: 10, #半径
                types: types, #検索タイプ
                location: location,
                sensor: false,
                key: APIKEY
            }

            # Google Places API用のGETリクエストを作成
            uristr = makeUri("https://maps.googleapis.com/maps/api/place/nearbysearch/json", cond)
            p uristr
            # URIの生成とJSONの取得
            uri = URI.parse(uristr)
            json = Net::HTTP.get(uri)
            cafes = JSON.parse(json)

            # ステータスコードがOKでない場合は何も空を返す
            if cafes["status"] != "OK" then
                puts "================"
                puts cafes
                puts "================"
                return {}
            else
                #カフェを一意に判定するのが正しいがとりあえずは1番上のもの
                return  cafes["results"][0]
            end
        end

        # params: user_id, cafename
        # チェックインを行う
        # checksテーブルにログを残す，checkinテーブルのstatusをINにする
        def checkin (user_id, cafename)
            chk = Check.new(
                    :user_id => user_id,
                    :cafename => cafename,
                    :action => "IN"
                )
            if !chk.save then
              render json: chk.errors.messages
            end
        end

        # params: user_id, cafename
        # チェックアウト情報をログに追加する
        def checkout (user_id, cafename)
            chk = Check.new(
                    :user_id => user_id,
                    :cafename => cafename,
                    :action => "OUT"
                )
            if !chk.save then
              render json: chk.errors.messages
            end
        end

        # params: source_id, target_ids
        # カフェ内にいる異性との関係を更新する
        # 出会ってから3時間経過しないと「再び出会ったとみなさない」
        def update_friendships(source_id, target_ids, cafename)
            for target_id in target_ids do
                friendship = Friendship.find_by(source_id: source_id, target_id: target_id)
                if friendship.nil? then
                    friendship = Friendship.create(
                        source_id: source_id,
                        target_id: target_id,
                        count: 1,
                        first_time: true,
                        cafename: cafename
                        )

                    # activitiesテーブルに追加
                    to_activity('meet', friendship)
                    p "======= new friendship created!! ========="
                elsif Time.now - friendship.updated_at > 3 * 3600 then
                    friendship.update(first_time: false, count: friendship.count + 1, cafename: cafename, updated_at: Time.now)
                    # activitiesテーブルに追加
                    to_activity('meet', friendship)
                    p "========= friendship updated! ============"
                else
                    p "======= friendship NOT updated ==========="
                end
            end
        end

        # activitiesテーブルにアクティビティを保存する
        # params: activity_code, friendship
        # user_id: アクティビティを表示する人
        # target_id: アクティビティの実行者
        # return: void
        def to_activity(activity_code, friendship)
            act = Activity.new(
                user_id: friendship.source_id,
                activity_code: activity_code,
                message: {user_id: friendship.target_id, count: friendship.count}.to_json
            )
            if !act.save then
                render json: '{"status": "ERROR - Activity Failed"}'
            end
        end
end
