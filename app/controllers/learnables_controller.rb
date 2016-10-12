class LearnablesController < ApplicationController
  def new
    @learnable = Learnable.new
  end

  def create 
    user = User.find(params[:learnable][:user_id])
    # skills selected in form
    selected_skill_ids = params[:skill_ids]
    # get category from form
    category = Category.includes(:skills).find(params[:learnable][:category_id]) 
    # find current skills from user
    current_skills = user.learnables.pluck(:skill_id)
    # find current skills in this category
    skills_in_cat = user.learnables.includes(:category).select {|item| item.skill.category == category }
    # get all the skills from the category
    category_skills = category.skills
    # loop through all category's skills, and if the skill is selected by the user, add it to their expertise. If the skill has not been selected, delete it. If the user has not selected any skills in the category, delete it.
    category_skills.each do | skill |
      learnable = Learnable.includes(:skill).where(user_id: user.id, skill_id: skill.id)
        if !selected_skill_ids.nil? && selected_skill_ids.include?(skill.id.to_s) 
          learnable.first_or_create
        elsif (!selected_skill_ids.nil? && learnable.exists?)
            Learnable.delete(learnable) 
        elsif learnable.exists?
          Learnable.delete(learnable) 
        end
      end

        respond_to do |format|
          @surveys = Survey.includes(:category).all
          if params[:learnable][:data_source]== 'user-form'
            format.js {render '/users/fetch_user_learning_menu.js.erb' }
          else
            format.js {render '/surveys/fetch_teaching_menu.js.erb' }
          end
        end
  end

  private

  def learnable_params
    params.require(:learnable).permit(:user_id,:skill_id)
  end

end