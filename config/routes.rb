Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, :path => 'search'
  resources :surveys, :path => 'match-me'
  resources :teachables
  resources :learnables
  root 'pages#index'
  get "/matches" => 'surveys#get_matches'

  # ajax via rails
  get "/fetch_learning" => 'surveys#fetch_learning', as: 'fetch_learning'
  get "/fetch_teaching_menu" => 'surveys#fetch_teaching_menu', as: 'fetch_teaching_menu'
<<<<<<< f12a374596e675d85e4b65fb9a008b39825d0a16
  root 'pages#index'

  namespace :api do
  	namespace :v1 do
    	get '/me' => 'credentials#me'
  	end
	end
	
  get 'discourse/sso' => 'discourse_sso#sso'

=======
  get "/fetch_teaching" => 'surveys#fetch_teaching', as: 'fetch_teaching'

  
>>>>>>> Add teaching section to match-me quiz and placeholder matches page
end