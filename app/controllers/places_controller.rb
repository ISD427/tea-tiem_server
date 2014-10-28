class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/index
    # params: location(latitude,longtitudeの形)
    # テスト用
    def index
        # user_id = paramas[:user_id]
        user_id = "A"
        location = params[:location]
        
        # デバッグ用
        if params[:location].nil? then
            location = "35.004982,135.765843"
        end

        @prev = Tmpplace.where(user_id: user_id).order(:updated_at).last

    end

    # GET /places/place.json
    # params: user_id, location(latitude, longtitude)
    # 現在地情報を受け取り，カフェにいるかどうかを判定する
    def place
        # =================================================
        # + チェックインしていない => 
        #   * 現在地がカフェ => 
        #       - 前の位置が現在地と同じ => Checkin処理
        #       - 前の位置が現在地と違う => Tmp更新
        #   * 現在地がカフェでない => 何もしない
        # + チェックインしている => 
        #   * 現在地がカフェ => 何もしない
        #   * 現在地がカフェでない => Checkout処理，Tmp更新
        # ==================================================

        # == 準備
        user_id = params[:user_id].nil? ? "A" : params[:user_id]
        location = "30.004982,135.765843"
        cafe = fetchPlace(location, "cafe") # APIからカフェを取得
        cafename = cafe["name"]

        # 前回取得時の場所を取得
        prev = Tmpplace.where(user_id: user_id).order(:updated_at).last
        # ステータス（checkin or checkout）
        status = Checkin.where(user_id: user_id).order(:updated_at).last

        # == ステータス判定
        case status.action
        when "OUT" then
            # 現在地がカフェの場合
            if !cafe.empty? then
                # 前回取得時と同じカフェの場合
                if prev.cafename == cafename then
                    check(user_id, cafename, "IN")
                    puts "CHECK IN : " + cafename
                # 前回取得時と異なるカフェの場合
                else
                    prev.update(cafename: cafename) # 前回位置情報を更新
                    puts "Next time you will CHECK IN"
                end
            # 現在地がカフェでない場合
            else
                puts "There is no cafes around here"
            end
        when "IN" then
            # 現在地がカフェでない場合
            if cafe.empty? then
                check(user_id, status.cafename, "OUT") # チェックアウト
                prev.update(cafename: "NULL") # 前回位置情報を更新
                puts "CHECK OUT : " + status.cafename
            # 現在地がカフェの場合，なにもしない
            else
                puts "You have been in the cafe"
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
        # チェックイン・チェックアウトを行う
        def check (user_id, cafename, action)
            chkin = Checkin.new(
                    :user_id => user_id,
                    :cafename => cafename,
                    :action => action
                )
            if !chkin.save then
              render json: '{"mesage" : "error: check parameters"}'
            end
        end
end
