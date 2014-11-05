json.array!(@res) do |friend|
    json.user_id friend[:user_id]
    json.user_name friend[:user_name]
    json.thumb friend[:thumb]
    json.first_time friend[:first_time]
    json.updated_at friend[:prev_time]
    json.latest_message friend[:last_message]
end

