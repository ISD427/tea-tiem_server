class FriendshipsController < ApplicationController
    # GET friendships/list
    # params: user_id
    # 表示可能な異性(1度でも出会ったことのある異性)を検索
    def list
        @friends = Friendship.where(source_id: params[:user_id])
        # ===========================
        # TODO: viewでimageも出す
        # ===========================
    end
end
