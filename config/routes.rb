Rails.application.routes.draw do
    get 'places/index'
    root 'places#index'
end
