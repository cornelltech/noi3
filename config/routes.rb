Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :path => 'search'
  resources :surveys, :path => 'match-me'
  resources :teachables
  resources :learnables
  root 'pages#index'
  get "/matches" => 'surveys#get_matches'

  # ajax via rails
  get "/fetch_learning" => 'surveys#fetch_learning', as: 'fetch_learning'
  get "/fetch_teaching_menu" => 'surveys#fetch_teaching_menu', as: 'fetch_teaching_menu'
  
  root 'pages#index'

  namespace :api do
  	namespace :v1 do
    	get '/me' => 'credentials#me'
  	end
	end
	
  get 'discourse/sso' => 'discourse_sso#sso'

  get "/fetch_teaching" => 'surveys#fetch_teaching', as: 'fetch_teaching'

  resources :projects

  put 'add_event' => 'users#add_event'
  delete 'remove_event' => 'users#remove_event'
  
  put 'add_topic' => 'pages#add_topic'

  # ajax devise views
  get 'fetch_sign_up' => 'pages#fetch_sign_up', as: 'fetch_sign_up'
  get 'fetch_log_in' => 'pages#fetch_log_in', as: 'fetch_log_in'
  get 'fetch_forgot_password' => 'pages#fetch_forgot_password', as: 'fetch_forgot_password'
  get 'fetch_edit_account' => 'pages#fetch_edit_account', as: 'fetch_edit_account'
end