class UsersController < ApplicationController

    # GET /users/detail
    # params: user_id, target_id
    # ユーザー詳細情報を取得
    def detail
        # ユーザー情報
        @user = User.find(params[:target_id])
        # ================================
        # TODO: ViewでImageを出す
        # ================================
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
    # params: user_id, [profile, image]
    # ユーザー情報を変更する
    def edit
        user = User.find(params[:user_id])
        if !params[:profile].nil? then
            user.profile = params[:profile]
        end

        # ===========================
        # TODO: imageの変更に対応する
        # ===========================
    end
end