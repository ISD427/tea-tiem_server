json.array!(@friends) do |friend|
    json.prev_cafename friend.cafename
    json.first_time friend.first_time
    json.time friend.time
    json.user_id friend.target.id
    json.user_name friend.target.username
end
