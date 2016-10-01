class SurveysController < ApplicationController

  def index
    @surveys = Survey.all
    @user = User.first
    @expertise = User.first.format_expertise
    @categories = Category.all
  end

  def new
    @survey = Survey.new

  end

  # def show
  #   @user = User.first
  #   @expertise = User.first.format_expertise
  #   @survey = Survey.find(params[:id])
  #   @skill_areas = @survey.category.skill_areas.map {|sa| sa}.uniq!
  #   render 'show'
  # end

  def fetch_learning
    @user = User.first
    @expertise = User.first.format_expertise
    @survey = Survey.find(params[:survey_id])
    @skill_areas = @survey.category.skill_areas.map {|sa| sa}.uniq!
    respond_to do |format|
        format.js
    end
  end

  def fetch_teaching_menu
    @surveys = Survey.all
  end

  def fetch_teaching
    @user = User.first
    @expertise = User.first.format_expertise
    @survey = Survey.find(params[:survey_id])
    @skill_areas = @survey.category.skill_areas.map {|sa| sa}.uniq!
    respond_to do |format|
        format.js
    end
  end

  def get_matches
    @user = User.first
    @expertise = User.first.format_expertise
    @categories = Category.all
    render 'matches'
  end

end