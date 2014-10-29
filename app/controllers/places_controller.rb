class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/index
    # params: location(latitude,longtitudeの形) 
    # テスト用
    def index
        @mates = findCafeMates(params[:user_id], params[:cafename])
    end

    # GET /places/place.json
    # params: user_id, location(latitude, longtitude)
    # 現在地情報を受け取り，カフェにいるかどうかを判定する
    def place
        # == 準備
        user_id = params[:user_id].nil? ? "user01" : params[:user_id]
        location = params[:location].nil? ? "35.004982,135.765843" : params[:location]
        currcafe = fetchPlace(location, "cafe") # APIからカフェを取得
        st = Status.find_by(user_id: user_id) # ステータスデータ

        # 現在地がカフェの場合
        if !currcafe.empty? then
            case st.status
            when "OUT" then
                @msg = currcafe['name'] + "　に次でチェックインできます"
                st.update(cafename: currcafe['name'], status: "WAITING")
            when "WAITING" then
                if st.cafename == currcafe['name'] then
                    @msg = currcafe['name'] + "　にチェックインしました"
                    checkin(user_id, currcafe['name'])
                    st.update(status: "IN")
                else
                    @msg = currcafe['name'] + "　に次でチェックインできます"
                    st.update(cafename: currcafe['name'], status: "WAITING")
                end
            when "IN" then
                if st.cafename == currcafe['name'] then
                    @msg = currcafe['name'] + "　にチェックイン済みです"
                else
                    @msg = st.cafename + "　からチェックアウトしました．" + currcafe['name'] + "　に次でチェックインできます．"
                    checkout(user_id, st.cafename)
                    st.update(cafename: currcafe['name'], status: "WAITING")
                end
            end
        # 現在地がカフェでない場合
        else
            case st.status
            when "OUT" then
                @msg = "近くにカフェがありません"
            when "WAITING" then
                @msg = st.cafename + "　はたまたま通りかかっただけですね"
                st.update(cafename: nil, status: "OUT")
            when "IN" then
                @msg = st.cafename + "　からチェックアウトしました"
                checkout(user_id, st.cafename)
                st.update(cafename: nil, status: "OUT")
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
              render json: '{"mesage" : "error: check parameters"}'
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
              render json: '{"mesage" : "error: check parameters"}'
            end
        end

        # params: user_id, cafename
        # 同じカフェにいる異性を探す
        def findCafeMates(user_id, cafename)
            user = User.find(user_id)
            tsex = (user.sex == "Male") ? "Female" : "Male"
            mates = Status.joins(:user).where("cafename = :cafename AND status = 'IN' AND users.sex = :sex", cafename: cafename, sex: tsex).where.not(user_id: user_id)
            return mates
        end
end
