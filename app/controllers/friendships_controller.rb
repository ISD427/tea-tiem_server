class FriendshipsController < ApplicationController
    # GET friendships/list
    # params: user_id
    # 表示可能な異性(1度でも出会ったことのある異性)を検索
    # メッセージが新しい人程上にくるように設計したかったからぐちゃぐちゃ
    def list
        friends = Friendship.where(source_id: params[:user_id]).order(updated_at: :desc)
        @res = []
        friends.each do |friend|
            # friendと自分の最後の会話を取得
            group = [friend.source_id, friend.target_id]
            m = Message.where(source_id: group, target_id: group, deleted: false).order(id: :desc).first

            # メッセージがなければテンプレートを用意
            if m.nil? then
                date = friend.updated_at.strftime("%m/%d")
                msg = date + "に出会いました"
                updated_at = friend.updated_at
            else
                msg = m.message
                updated_at = (friend.updated_at > m.updated_at) ? friend.updated_at : m.updated_at
            end

            f =  {
                user_id: friend.target_id,
                user_name: friend.target.username,
                count: friend.count,
                prev_time: updated_at, 
                last_message: msg
                }
            f[:thumb] = friend.count == 1 ? friend.target.image(:mosaic) : friend.target.image(:thumb)
            @res.push(f)
        end
        @res = @res.sort_by{|val| val[:prev_time]}.reverse

    end
end
