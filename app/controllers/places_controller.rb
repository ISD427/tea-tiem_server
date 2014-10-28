class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/index
    # params: location(latitude,longtitudeの形)
    # テスト用
    def index
        @mates = findCafeMate("user01", "collection")
    end

    # GET /places/place.json
    # params: user_id, location(latitude, longtitude)
    # 現在地情報を受け取り，カフェにいるかどうかを判定する
    def place
        # =================================================
        # + チェックインしていない => 
        #   * 現在地がカフェ => 
        #       - 前の位置が現在地と同じ => Check, Checkin処理(status = IN)
        #       - 前の位置が現在地と違う => Checkin処理(status = PROCESS)
        #   * 現在地がカフェでない => 何もしない
        # + チェックインしている => 
        #   * 現在地がカフェ => 何もしない
        #   * 現在地がカフェでない => Check処理，Checkin処理(削除)
        # ==================================================

        # == 準備
        user_id = params[:user_id].nil? ? "user01" : params[:user_id]
        location = params[:location].nil? ? "35.004982,135.765843" : params[:location]
        cafe = fetchPlace(location, "cafe") # APIからカフェを取得


        # 現在地がカフェの場合
        if !cafe.empty? then
            # カフェ名とステータスの取得
            cafename = cafe["name"]
            chkin = Checkin.find_by(user_id: user_id, cafename: cafename)

            if chkin.nil? then
                toWaiting(user_id, cafename)
                puts cafename + "に次でチェックインできます"
            elsif chkin.status == "WAITING" then
                checkin(user_id, cafename)
                puts cafename + "にチェックインしました"
            elsif chkin.status == "IN" then
                puts "既にチェックイン済みです．ゆっくりしていってね！"
            end
        # 現在地がカフェでない場合
        else
            chkin = Checkin.find_by(user_id: user_id)
            # checkins
            if !chkin.nil? then
                case chkin.status
                when "IN"
                    checkout(user_id, chkin.cafename)
                    puts chkin.cafename + "からチェックアウトしました"
                when "WAITING"
                    Checkin.destroy_all(user_id: user_id)
                    puts chkin.cafename + "は通りかかっただけですね"
                end
            else
                puts "近くにカフェがありません"
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

            # URIの生成とJSONの取得
            uri = URI.parse(uristr)
            json = Net::HTTP.get(uri)
            cafes = JSON.parse(json)

            # ステータスコードがOKでない場合は何も空を返す
            if cafes["status"] != "OK" then
                puts cafes["status"]
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
            chkin = Checkin.find_by(user_id: user_id)
            chkin.update(status: "IN")

            if !chk.save then
              render json: '{"mesage" : "error: check parameters"}'
            end
        end

        # params: user_id, cafename
        # チェックアウトを行う
        # checksテーブルにログを残す，checkinテーブル
        def checkout (user_id, cafename)
            chk = Check.new(
                    :user_id => user_id,
                    :cafename => cafename,
                    :action => "OUT"
                )
            Checkin.destroy_all(user_id: user_id)
            if !chk.save then
              render json: '{"mesage" : "error: check parameters"}'
            end
        end

        # params: user_id, cafename
        # チェックイン待機状態(status = WAITING)にする
        def toWaiting (user_id, cafename)
            # レコードがあれば更新，なければ作成
            if Checkin.where(user_id: user_id).exists? then
                Check.find_by(user_id: user_id).update(cafename: cafename, status: "WAITING")
            else
                chkin = Checkin.new(
                        user_id: user_id,
                        cafename: cafename,
                        status: "WAITING"
                    )
                if !chkin.save then
                    render text: chkin.errors.messages
                end 
            end
        end

        # params: user_id, cafename
        # 同じカフェにいる異性を探す
        def findCafeMate(user_id, cafename)
            user = User.find(user_id)
            tsex = (user.sex == "Male") ? "Female" : "Male"
            mates = Checkin.joins(:user).where("cafename = :cafename AND status = 'IN' AND users.sex = :sex", cafename: cafename, sex: tsex).where.not(user_id: user_id)
            return mates
        end
end
