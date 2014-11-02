Rails.application.routes.draw do
    get 'places/index'
    get 'places/place'
    get 'places/friend_list'

    get 'users/detail'
    post 'users/add'
    post 'users/edit'

    get 'friendships/list'

    get '/messages/receive'
    post '/messages/write'
    post 'messages/delete'
end
