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
        # imageがuriの場合はDLしてから格納．ファイルの場合はそのまま格納
        img = Image.new(
            :user_id => params[:user_id],
            :deleted => false,
            :icon => true
            )
        if params[:image].class == String then
            img.image_from_url(params[:image])
        else
            img.image = params[:image]
        end

        if !img.save then
            render json: '{"status": "ERROR"}'
        end

        user = User.new(
            :id => params[:user_id],
            :username => params[:user_name],
            :sex => params[:sex],
            :icon => img.image(:thumb)
            )

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
    # params: user_id, [profile, user_name]
    # ユーザー情報を変更する
    def edit
        user = User.find(params[:user_id])
        if !params[:profile].nil? then
            user.profile = params[:profile]
        end
        if !params[:user_name].nil? then
            user.username = params[:user_name]
        end
        if user.save then 
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end
end