json.array!(@friends) do |friend|
    json.user_id friend.target.id
    json.user_name friend.target.username
    if friend.first_time? then
        json.thumb friend.target.image(:mosaic)
    else
        json.thumb friend.target.image(:thumb)
    end
    json.first_time friend.first_time
    json.prev_cafe_name friend.cafename
    json.prev_time friend.updated_at
end
