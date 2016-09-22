class UsersController < ApplicationController

  def index
    @users = User.all
    @categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]
  end

  def fetch_user 
    @selected = User.find(params[:user_id])
    respond_to do | format |
      format.js
    end
  end
  

end
