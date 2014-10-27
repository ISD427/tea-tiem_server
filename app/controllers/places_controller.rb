class PlacesController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'

    # GET /places/index
    # params: locatioin(latitude,longtitudeの形)
    # 座標を受け取り，現在いるカフェを返す
    def index

        # APIリクエストの作成
        cond = {
            radius: 10, #半径
            types: "cafe", #検索タイプ
            location: "35.000072,135.765843",
            sensor: false
        }

        if !params[:location].nil? then
            cond[:location] = params[:location]
        end

        uristr = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        uristr << "?radius=" + cond[:radius].to_s
        uristr << "&types=" + cond[:types]
        uristr << "&location=" + cond[:location]
        uristr << "&sensor=" + cond[:sensor].to_s
        uristr << "&key=" + APIKEY

        # URIの生成とJSONの取得
        uri = URI.parse(uristr)
        @place = Net::HTTP.get(uri)
        @result = JSON.parse(@place)
        @hoge = {"tokyo" => "japan", "Roma" => "Italy"}
    end
end
