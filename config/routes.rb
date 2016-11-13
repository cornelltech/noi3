Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  resources :users, :path => 'search'
  resources :users, :path => 'profile', :as => 'profile'
  resources :surveys, :path => 'match-me'
  resources :teachables
  resources :learnables
  get '/' => 'welcome#southaustralia', as: 'welcome-southaustralia', constraints: { subdomain: 'southaustralia' }

  root 'pages#index'
  get "/matches" => 'surveys#get_matches'

  # ajax via rails
  get '/fetch_user' => "users#fetch_user", as: "fetch_user"
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

  put 'add_and_remove_events' => 'users#add_and_remove_events'


  put 'add_topic' => 'pages#add_topic'

  # ajax devise views
  get 'fetch_sign_up' => 'pages#fetch_sign_up', as: 'fetch_sign_up'
  get 'fetch_log_in' => 'pages#fetch_log_in', as: 'fetch_log_in'
  get 'fetch_forgot_password' => 'pages#fetch_forgot_password', as: 'fetch_forgot_password'
  get 'fetch_edit_account' => 'pages#fetch_edit_account', as: 'fetch_edit_account'
  get 'fetch_edit_user' => 'pages#fetch_edit_user', as: 'fetch_edit_user'
  get 'fetch_edit_project' => 'projects#fetch_edit_project', as: 'fetch_edit_project'

  # user ajax views for expertise panels
  get 'fetch_user_learning_menu' => 'users#fetch_user_learning_menu', as: 'fetch_user_learning_menu'
  get 'fetch_user_teaching_menu' => 'users#fetch_user_teaching_menu', as: 'fetch_user_teaching_menu'
  get 'fetch_learning_survey' => 'users#fetch_learning_survey', as: 'fetch_learning_survey'
  get 'fetch_teaching_survey' => 'users#fetch_teaching_survey', as: 'fetch_teaching_survey'

  # projects ajax for categories/subcategories
  get 'update_subcategory_dropdown' => 'projects#update_subcategory_dropdown', as: 'update_subcategory_dropdown'

  get '/sign_up_success' => 'pages#sign_up_success', as: 'sign_up_success'

  get '/welcome' => 'welcome#index', as: 'welcome'

  get '/delete_account_success' => 'pages#delete_account_success', as: 'delete_account_success'

  get 'delete_oauth_provider' => "users#delete_oauth_provider", as: 'delete_oauth_provider'

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup



end
