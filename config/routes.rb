Rails.application.routes.draw do
  devise_for :users
    # resources :users
  root 'pages#index'
  get 'search', :to => 'users#index'
end