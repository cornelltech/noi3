class UsersController < ApplicationController

  def index
    @user = "DENNNY"
    @categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]
  end

end
