Rails.application.routes.draw do
  devise_for :users
    # resources :users
  root 'pages#index'
  get 'search', :to => 'users#index'
  get '/fetch_user' => "users#fetch_user", as: "fetch_user"
end