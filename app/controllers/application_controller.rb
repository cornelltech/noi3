class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
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
<<<<<<< 2db83205001703e13b383d6765a57d778d156d7a
  end

  private

  def set_user
    cookies[:username] = current_user || 'guest'
=======
  end  
    
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.username
      redirect_to finish_signup_path(current_user)
    end
>>>>>>> Add working oauth and post signup username
  end

end
