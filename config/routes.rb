Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'sellers/login' => "sellers#login"
  post 'sellers/loggedin'
  get 'sellers/logout'
  get 'users/login' => "users#login"
  post 'users/loggedin'
  get 'users/logout'
  resources :items
  resources :sellers
  resources :users
end
