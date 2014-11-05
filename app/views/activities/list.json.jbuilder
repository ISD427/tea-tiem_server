json.array!(@activities_hash) do |activity|
    json.activity_code activity[:activity_code]
    json.message activity[:message]
    json.time activity[:time]

    json.user do
        if activity[:friendship].first_time? then
            json.thumb activity[:user].image(:mosaic)
        else
            json.thumb activity[:user].image(:thumb)
        end
        json.user_id activity[:user].id
        json.user_name activity[:user].username
    end
end