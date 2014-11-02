Rails.application.routes.draw do
    get 'places/place'
    get 'places/friend_list'

    get 'users/detail'
    post 'users/add'
    post 'users/edit'
    post 'users/test'

    get 'friendships/list'

    get '/messages/receive'
    post '/messages/write'
    post 'messages/delete'

    get '/images/list'
    post '/images/add'
    post '/images/delete'
    post '/images/icon'
end
