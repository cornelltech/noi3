class WelcomeController < ActionController::Base
  protect_from_forgery with: :exception

  def index
      render layout: false
  end

  def southaustralia
      render layout: false
  end

end
