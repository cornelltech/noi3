class ApplicationController < ActionController::Base
  include HTTParty
  protect_from_forgery with: :exception
  before_action :set_user, :set_notifications

  # before_action :authenticate_user!

  # DEVISE HELPERS for forms
  helper_method :resource_name, :resource, :devise_mapping

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
    @notifications = []
    @host = nil

    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
# byebug
    if @user && @user.username
      notifications_json = HTTParty.get(discourse_client.host + "/notifications.json?username=" + discourse_client.api_username + "&api_key=" + discourse_client.api_key + "&api_username=" + discourse_client.api_username)

      @host = discourse_client.host

      if notifications_json["notifications"]
        notifications_json["notifications"].each do |notification|
          if notification["read"] = true
            @notifications << 1
          end
        end
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

end
