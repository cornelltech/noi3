class TeachablesController < ApplicationController
  def new
    @teachable = Teachable.new
  end

  def create 
    user = User.find(params[:teachable][:user_id])
    # byebug
    # skills selected in form
    selected_skill_ids = params[:skill_ids]
    # get category from form
    puts "Selected Skills"
    puts selected_skill_ids
    category = Skill.find(selected_skill_ids.first).category 
    # find current skills from user
    current_skills = user.teachables.pluck(:skill_id)
    # find current skills in this category
    puts "Current Skills"
    puts current_skills
    skills_in_cat = user.teachables.includes(:category).select {|item| item.skill.category == category }
    # get all the skills from the category
    category_skills = category.skills

    category_skills.each do | skill |
      teachable = Teachable.where(user_id: user.id, skill_id: skill.id)
        if selected_skill_ids.include?(skill.id.to_s)
          teachable.first_or_create
        else
          if teachable.exists?
            Teachable.delete(teachable) 
          end
        end
      end
      if params[:teachable][:data_source]== 'user-form'
        respond_to do |format|
          @surveys = Survey.all
          format.js {render '/users/fetch_user_teaching_menu.js.erb' }
        end
      else
        redirect_to matches_path
      end
  end

  private

  def teachable_params
    params.require(:teachable).permit(:user_id,:skill_id)
  end

end