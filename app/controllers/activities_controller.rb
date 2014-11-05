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
                activity_hash = {
                    time: activity.created_at,
                    activity_code: activity.activity_code,
                    message: msg,
                    user: user
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
            user = User.find(msg_obj['user_id']) # user

            case activity.activity_code
            when 'meet' then
                msg = MESSAGES['meet'].gsub(/\%username\%/, user.username)
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

end
