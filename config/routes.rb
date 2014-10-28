Rails.application.routes.draw do
    get 'places/index'
    get 'places/place'
    root 'places#index'
end
