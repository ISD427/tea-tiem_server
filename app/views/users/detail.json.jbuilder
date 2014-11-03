json.user_id @user.id
json.user_name @user.username
json.age @user.age
json.profile @user.profile
if @fs.first_time? then
    json.image nil
    json.thumb @user.image(:mosaic)
else
    json.image @user.image(:large)
    json.thumb @user.image(:thumb)
end
json.friendship @friendship