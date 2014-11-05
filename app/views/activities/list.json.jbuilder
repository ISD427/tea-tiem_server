json.array!(@activities_hash) do |activity|
    json.activity_code activity[:code]
    json.message activity[:message]
    json.time activity[:time]

    json.user do
        json.thumb activity[:user].image(:thumb)
        json.user_id activity[:user].id
        json.user_name activity[:user].username
    end
end