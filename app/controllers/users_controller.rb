class UsersController < ApplicationController

  def index
    @users = User.all
    @categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: {:user => @user, :projects => @user.projects, :events => @user.events, :categories => @user.categories}}
    end
  end

  def fetch_user 
    @selected = User.find(params[:user_id])
    respond_to do | format |
      format.js
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :email, :password, :points)
  end

end
