json.user_id @user.id
json.user_name @user.username
json.profile @user.profile
json.images do
    json.array!(@user.images) do |image|
        json.image_id image.id
        json.url image.image(:large)
    end
end