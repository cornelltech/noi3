class PagesController < ApplicationController
  def index
    @categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]
  end


end