json.cafename @cafename
json.users do
    json.array!(@friendships) do |friendship|
        json.count friendship.count
        json.user_id friendship.target.id
        json.user_name friendship.target.username
        if friendship.first_time?
            json.thumb friendship.target.image(:mosaic)
        else
            json.thumb friendship.target.image(:thumb)
        end
    end
end