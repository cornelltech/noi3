class UsersController < ApplicationController

  def index
    @users = User.all
    @expertise = User.first.format_expertise
    @main_expertise = User.first.format_main_expertise
    @categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]
  end

  def show
    @user = User.find(params[:id])
    @expertise = @user.format_expertise
    respond_to do |format|
      format.html 
      format.json { render json: {:user => @user, :industries => @user.industries, :expertise => @user.format_expertise, :main_expertise => @user.format_main_expertise, :projects => @user.projects, :events => @user.events, :categories => @user.categories}}
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
