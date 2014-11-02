json.messages do
    json.array!(@msgs) do |msg|
        json.message_id msg.id
        json.message msg.message
        json.sender_id msg.source.id
        json.time msg.created_at
    end
end
json.source_user do
    json.user_id @source_user.id
    json.user_name @source_user.username
    json.thumb @source_user.image(:thumb)
end
json.target_user do
    json.user_id @target_user.id
    json.user_name @target_user.username
    json.thumb @target_user.image(:thumb)
end
