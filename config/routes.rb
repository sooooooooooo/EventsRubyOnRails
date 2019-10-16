Rails.application.routes.draw do
  get 'comments/create'

  get 'joins/create'

  get 'joins/destroy'

  # get 'events/index'

  # get 'events/show'

  # get 'users/index'

  # get 'users/create'

  root "users#index"

  resources :users
  resources :events
  resources :joins
  resources :comments

  post "login" => "users#login"
  post "logout" => "users#logout"

  get "*path" => redirect("/")

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
