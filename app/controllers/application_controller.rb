class ApplicationController < ActionController::Base
  include HTTParty
  protect_from_forgery with: :exception
  before_action :set_user, :set_notifications

  # before_action :authenticate_user!

  # DEVISE HELPERS for forms
  helper_method :resource_name, :resource, :devise_mapping, :page_flags, :set_page_flags

  def page_flags
    @page_flags
  end

  def set_page_flags(flags)
    @page_flags ||= flags
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  private

  def set_user
    cookies[:username] = current_user || 'guest'
  end

  def set_notifications
    @user = current_user
    @notifications = false
    @host = nil
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
    if @user && @user.username
      notifications_json = discourse_client.get("notifications?username=#{@user.username}")
      @host = discourse_client.host + "/users/" + @user.username + "/notifications"
      if notifications_json["body"]["notifications"]
        @notifications = notifications_json["body"]["notifications"].map {|n| n["read"]}.include?(false)
      end
    end
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'
    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.username
      redirect_to finish_signup_path(current_user)
    end
  end

  # for oauth
  def after_sign_in_path_for(resource)
    # if resource.sign_in_count < 2
    #   '/connect'
    # else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    # end
  end

end
