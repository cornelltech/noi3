Rails.application.routes.draw do
  use_doorkeeper
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, :path => 'search'
  root 'pages#index'

  namespace :api do
  	namespace :v1 do
    	get '/me' => 'credentials#me'
  	end
	end
	
end