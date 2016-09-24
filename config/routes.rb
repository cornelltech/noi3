Rails.application.routes.draw do
  devise_for :users
  resources :users, :path => 'search'
  root 'pages#index'
end