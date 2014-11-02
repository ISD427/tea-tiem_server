class ImagesController < ApplicationController
    # GET /images/list
    # params: user_id
    # 写真を取得する
    def list
        @imgs = Image.where(user_id: params[:user_id])
    end

    # POST /images/add
    # params: user_id, image(File)
    # 写真を登録する
    def add
        # 初めての画像ならばアイコン用にする
        flag = Image.where(user_id: params[:user_id], icon: true).exists? ? false : true

        img = Image.new(
            user_id: params[:user_id],
            image: params[:image],
            deleted: false,
            icon: flag
            )

        if img.save then
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end

    # POST /images/delete
    # params: user_id, image_id
    # 写真を削除する(論理削除)
    def delete
        img = Image.find(params[:image_id])
        if img.update(deleted: true) then
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end

    # POST /images/icon
    # params: user_id, image_id
    # 指定した写真をアイコンに利用する
    def icon
        new_img = Image.find(params[:image_id])
        old_img = Image.find_by(user_id: params[:user_id], icon: true)
        user = User.find(params[:user_id])

        if new_img.update(icon: true) && old_img.update(icon: false) && user.update(icon: new_img.image(:thumb))then
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end
end
