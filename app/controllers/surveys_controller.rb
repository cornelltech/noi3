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
    # users = User.all
    @user = current_user

    @categories = Category.all
    @skills = Skill.all

    # Temporary matching solution. 
    user_teachables = @user.teachables.pluck(:skill_id)
    user_learnables = @user.learnables.pluck(:skill_id)
    @matches = []

    # don't go through all users. preselect users that have overlap already and go through those only
    user_ids = Teachable.where(skill_id: user_learnables).map { |item| item.user_id }
    user_ids << Learnable.where(skill_id: user_teachables).map { |item| item.user_id }    
    users = User.find(user_ids.flatten.uniq)
    puts users.count

    users.each do | user_match |
      puts "********** here I am"
      user_match.can_teach  = user_match.teachables.pluck(:skill_id) & user_learnables
      user_match.can_learn = user_match.learnables.pluck(:skill_id) & user_teachables
      if ((user_match.can_teach.count + user_match.can_learn.count) > 0) && (current_user.id != user_match.id)
        @matches << user_match
      end
    end

    @matches = @matches.sort_by {|match| match.can_teach.count + match.can_learn.count }.reverse!

    render 'matches'
  end

  def temp_profile_setup
    
  end

end