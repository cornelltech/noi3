Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, :path => 'search'
  resources :surveys
  root 'pages#index'

  namespace :api do
  	namespace :v1 do
    	get '/me' => 'credentials#me'
  	end
	end
	
  get 'discourse/sso' => 'discourse_sso#sso'

end