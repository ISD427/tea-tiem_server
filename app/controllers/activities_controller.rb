class ActivitiesController < ApplicationController
    # GET /activities/list
    # params: user_id
    # 最近のアクティビティ20件を取得する
    def list
        activities = Activity.where(user_id: params[:user_id]).order(created_at: :desc).limit(20)
        @activities_hash = to_hash(activities)
    end

    private
        # params: activities
        # return: Hash
        # DBから酒盗したhistoryデータをHashに整形する
        def to_hash(activities)
            activities_list= []
            activities.each do |activity|
                msg = make_msg(activity) # メッセージ作成
                user = get_user(activity) # activityの実行者
                friendship = get_friendship(activity)
                activity_hash = {
                    time: activity.created_at,
                    activity_code: activity.activity_code,
                    message: msg,
                    user: user,
                    friendship: friendship
                }
                activities_list << activity_hash
            end
            return activities_list
        end

        # activity_codeに応じたメッセージを作成
        # params: activity
        # return: msg:string
        def make_msg(activity)
            msg_obj = JSON.parse(activity.message) # String -> Hash
            target_user = User.find(msg_obj['user_id']) # アクティビティの実行者

            case activity.activity_code
            when 'meet' then
                count = msg_obj['count'] # カウント
                msg = MESSAGES['meet'].gsub(/\%username\%/, target_user.username).gsub(/\%count\%/, count.to_s)
            else
                msg = "アクティビティがありました"
            end
        end

        # アクティビティを行ったユーザーを取得
        # params: activity
        def get_user(activity)
            messages = JSON.parse(activity.message)
            user = User.find(messages['user_id'])
            return user
        end

        # 閲覧者とアクティビティ実行者の関係を取得
        # params: activity
        def get_friendship(activity)
            source_id = activity.user_id
            target_id = JSON.parse(activity.message)['user_id']
            friendship = Friendship.find_by(source_id: source_id, target_id: target_id)
            return friendship
        end

end
