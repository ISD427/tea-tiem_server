json.user_id @user.id
json.user_name @user.username
json.profile @user.profile
json.image @user.image(:large)
json.thumb @user.image(:thumb)