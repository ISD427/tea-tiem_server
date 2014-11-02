class MessagesController < ApplicationController

    # GET /messages/receive.json
    # params: source_id, target_id, [after_id, before_id]
    # メッセージを受信する
    # before_id, after_idを指定すると，そのidより前[後]のメッセージを取得
    # 両方指定された時はafter_idのみ
    # 両方指定されない場合は最新の30件を取得
    def receive
        group = [params[:source_id], params[:target_id]]
        @source_user = User.find(params[:source_id])
        @target_user = User.find(params[:target_id])
        @msgs = Message.where(source_id: group, target_id: group, deleted: false).order(id: :desc)
        if params[:after_id].nil? && params[:before_id].nil? then
            # 最新30件を取得
            @msgs.limit!(30)
        elsif !params[:after_id].nil? then
            # after_id以降のメッセージを全て取得
            @msgs.where!('id > ?',params[:after_id])
        else
            # before_id以前のメッセージを30件取得
            @msgs.where!('id < ?', params[:before_id]).limit!(30)
        end
    end

    # POST /messages/send
    # params: source_id, target_id, message
    # メッセージを送信する
    def write
        msg = Message.new(
            :source_id => params[:source_id],
            :target_id => params[:target_id],
            :message => params[:message],
            :deleted => false
            )
        if msg.save then
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR"}'
        end
    end


    # POST /messages/delete
    # params: user_id, message_id
    # メッセージを削除するs
    # 処理上はdeletedフラグをtrueに変更
    def delete
        msg = Message.find(params[:message_id])
        if msg.source.id == params[:user_id] then 
            msg.update(deleted: true)
            render json: '{"status": "OK"}'
        else
            render json: '{"status": "ERROR". Check your user_id}'
        end
    end

end
