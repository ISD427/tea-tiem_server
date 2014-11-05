Rails.application.routes.draw do
    get 'places/place'
    get 'places/friend_list'

    get 'users/detail'
    get 'users/own_detail'
    post 'users/add'
    post 'users/edit'

    get 'friendships/list'

    get 'messages/receive'
    post 'messages/write'
    post 'messages/delete'

    get 'activities/list'
end
