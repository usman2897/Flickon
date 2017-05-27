Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'sellers/login' => "sellers#login"
  post 'sellers/loggedin'
  get 'sellers/logout'
  get 'users/login' => "users#login"
  post 'users/loggedin'
  get 'users/logout'
  get 'orders/myorders'
  get 'sellers/dashboard'
  get 'sellers/dispatched'
  get 'sellers/deliver'
  get 'items/cat'
  get 'sellers/my_items'
  resources :items
  resources :sellers
  resources :order_tracks
  resources :orders
  resources :users
  root 'items#index'
end
