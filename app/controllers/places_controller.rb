class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/index
    # params: locatioin(latitude,longtitudeの形)
    # 座標を受け取り，半径10m以内にあるカフェを返す
    # なければ空オブジェクトが返るはず
    def index
        # APIリクエストの作成
        cond = {
            radius: 10, #半径
            types: "cafe", #検索タイプ
            location: "35.000072,135.765843",
            sensor: false,
            key: APIKEY
        }

        # デバッグ用
        if !params[:location].nil? then
            cond[:location] = params[:location]
        end

        # Google Places API用のGETリクエストを作成
        uristr = makeUri("https://maps.googleapis.com/maps/api/place/nearbysearch/json", cond)

        # URIの生成とJSONの取得
        uri = URI.parse(uristr)
        @place_json = Net::HTTP.get(uri)
        @result = JSON.parse(@place_json)
    end

    # GET /places/
    # params: user_id, location(latitude, longtitude)
    # 現在地情報を受け取り，カフェにいるかどうかを判定する
    def judge (user_id, location)
        # 現在地がカフェかを判定
        if isCafe(location) then
            # カフェにいるならば，最新の状況を調べる
            if isLongCafe(user_id) then 
                # 前回の場所もカフェならばカフェ判定をtrueにする
            else
                # 前回の場所がカフェじゃ無いならカフェ判定をfalseにする
                # それと同時に最新の場所をカフェにする
            end
        end
    end

    private
        # uriとパラメータからリクエストURIを作成
        def makeUri(uri, params)
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

        # 現在地情報からカフェにいるかを判定する
        def isCafe (location)
            
        end
end
