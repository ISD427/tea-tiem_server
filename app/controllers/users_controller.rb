class UsersController < ApplicationController

    # GET /users/detail
    # params: user_id, target_id
    # 指定ユーザーの詳細情報と自身との関係を取得
    def detail
        # ユーザー情報
        @user = User.find(params[:target_id])
        @fs = Friendship.find_by(source_id: params[:user_id], target_id: params[:target_id])
        if !@fs.nil? then
            @friendship = {
            prev_cafe_name: @fs.cafename,
            prev_time: @fs.updated_at,
            first_time: @fs.first_time
            }
        else
            render json: '{"status": "ERROR - No Friendship"}'
        end
    end

    # GET /users/own_detail
    # params: user_id
    # 自身のアカウント情報を取得
    def own_detail
        @user = User.find(params[:user_id])
    end


    # POST /users/add
    # params: user_id, user_name, sex, age, image, [profile]
    # ユーザーの追加（新規登録）を行う
    def add
        user = User.new(
            :id => params[:user_id],
            :username => params[:user_name],
            :sex => params[:sex],
            :age => params[:age]
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

        # Statusレコードを追加
        Status.create(
            user_id: params[:user_id],
            status: "OUT"
            )

        if user.save then
            render json: '{"status": "OK"}'
        else
            render json: user.errors.messages
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