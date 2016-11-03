class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
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

end
