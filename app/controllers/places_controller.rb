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
        # + チェックインしていない場合
        #   * 現在地がカフェの場合
        #       - 前の位置が現在地と同じ場合，Checkin処理
        #       - 前の位置が現在地と違う場合，Tmp更新
        #   * 現在地がカフェでない場合，何もしない
        # + チェックインしている場合
        #   * 現在地がカフェの場合，何もしない
        #   * 現在地がカフェでない場合，Checkout処理・Tmp更新
        # ==================================================

        # == 準備
        user_id = params[:user_id].nil? ? "A" : params[:user_id]
        location = "30.004982,135.765843"
        #カフェ情報を取得
        cafe = fetchPlace(location, "cafe")
        puts cafe
        cafename = cafe["name"]
        # 前回位置を取得
        prev = Tmpplace.where(user_id: user_id).order(:updated_at).last
        # 現在のチェックイン状態を取得
        status = Checkin.where(user_id: user_id).order(:updated_at).last

        # == ステータス判定
        # チェックインしていない場合
        if status.action == "OUT" then
            # 現在地がカフェの場合
            if !cafe.empty? then
                if prev.cafename == cafename then 
                    # 前回の場所と同じカフェの場合はCheckin処理
                    chkin = Checkin.new(
                            :user_id => user_id,
                            :cafename => cafename,
                            :action => "IN"
                        )
                    chkin.save
                    @result = "No checkin, Yes now cafe, Yes prev cafe"
                else
                    # 前回と違う場合はTmpplaceを新しいカフェ名に更新
                    prev.update(cafename: cafename)
                    @result = "No checkin, Yes now cafe, No prev cafe"
                end
            # 現在地がカフェにいない場合
            else
                puts "カフェにいませんことよ"
                puts "何もしませんことよ"
                @result = "No checkin, No now cafe"
            end
        # チェックインしている場合
        else
            # 現在地がカフェでない場合
            if cafe.empty? then
                # チェックアウト処理
                chkout = Checkin.new(
                        :user_id => user_id,
                        :cafename => status.cafename,
                        :action => "OUT"
                    )
                chkout.save
                # Tmpplaceを更新
                prev.update(cafename: "NULL")
                @result = "Yes checkin, No now cafe"
            # 現在地がカフェの場合，なにもしない
            else
                @result = "Yes checkin, Yes now cafe"
                puts "カフェにいますことよ"
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
        # Google Places APIを用いてJsonを取得する
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
end
