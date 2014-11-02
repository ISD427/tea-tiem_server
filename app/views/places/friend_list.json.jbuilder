json.cafename @cafename
json.users do
    json.array!(@friendships) do |friendship|
        json.first_time friendship.first_time
        json.user_id friendship.target.id
        json.user_name friendship.target.username
        json.thumb friendship.target.image(:thumb)
    end
end