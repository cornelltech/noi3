class SurveysController < ApplicationController

  def index
    @users = User.all
    @surveys = Survey.all
    @categories = Category.all
  end

  def new
    @survey = Survey.new
  end


  def fetch_learning
    @user = current_user
    @expertise = current_user.format_expertise
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
    @user = current_user
    @expertise = current_user.format_expertise
    @survey = Survey.find(params[:survey_id])
    @skill_areas = @survey.category.skill_areas.map {|sa| sa}.uniq!
    respond_to do |format|
        format.js
    end
  end

  def get_matches
    users = User.all
    @user = current_user

    @categories = Category.all
    @skills = Skill.all

    # Temporary matching solution. 
    user_teachables = @user.teachables.pluck(:skill_id)
    user_learnables = @user.learnables.pluck(:skill_id)

    @matches = users.each do | user_match |
      user_match.can_teach = user_match.teachables.pluck(:skill_id) & user_learnables
      user_match.can_learn = user_match.learnables.pluck(:skill_id) & user_teachables
    end.sort_by {|match| match.can_teach + match.can_learn}.reverse!
    render 'matches'
  end

  def temp_profile_setup
    
  end

end