Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, :path => 'search'
  resources :surveys, :path => 'match-me'
  resources :teachables
  resources :learnables
  get "/fetch_learning" => 'surveys#fetch_learning', as: 'fetch_learning'
  get "/fetch_teaching_menu" => 'surveys#fetch_teaching_menu', as: 'fetch_teaching_menu'
  root 'pages#index'

  namespace :api do
  	namespace :v1 do
    	get '/me' => 'credentials#me'
  	end
	end
	
  get 'discourse/sso' => 'discourse_sso#sso'

end