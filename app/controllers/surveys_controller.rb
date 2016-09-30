class SurveysController < ApplicationController

  def index
    @surveys = Survey.all
    @user = User.first
    @expertise = User.first.format_expertise

  end
end