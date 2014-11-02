class UsersController < ApplicationController

    # GET /users/detail
    # params: user_id
    # ユーザー詳細情報を取得
    def detail
        # ユーザー情報
        @user = User.find(params[:user_id])
    end


    # POST /users/add
    # params: user_id, user_name, sex, image, [profile]
    # ユーザーの追加（新規登録）を行う
    def add
        user = User.new(
            :id => params[:user_id],
            :username => params[:user_name],
            :sex => params[:sex],
            )
        if params[:image].class == String then
            user.image = URI.parse(params[:image])
        else
            user.image = params[:image]
        end

        # profile
        if !params[:profile].nil? then
            user.profile = params[:profile]
        end


        if user.save then
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end

    # POST /users/edit
    # params: user_id, [profile, user_name, image]
    # ユーザー情報を変更する
    def edit
        user = User.find(params[:user_id])
        if !params[:profile].nil? then
            user.profile = params[:profile]
        end
        if !params[:user_name].nil? then
            user.username = params[:user_name]
        end
        if !params[:image].nil? then
            user.image = params[:image]
        end
        if user.save then 
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end
end