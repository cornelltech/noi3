class TeachablesController < ApplicationController
  def new
    @teachable = Teachable.new
  end

  def create 
    user = User.find(params[:teachable][:user_id])
    # skills selected in form
    selected_skill_ids = params[:skill_ids]
    # get category from form
    category = Category.includes(:skills).find(params[:teachable][:category_id]) 
    # find current skills from user
    current_skills = user.teachables.pluck(:skill_id)
    # find current skills in this category
    skills_in_cat = user.teachables.includes(:skill, :category).select {|item| item.skill.category == category }
    # get all the skills from the category
    category_skills = category.skills
    # loop through all category's skills, and if the skill is selected by the user, add it to their expertise. If the skill has not been selected, delete it. If the user has not selected any skills in the category, delete it.
    category_skills.each do | skill |
      teachable = Teachable.includes(:skill).where(user_id: user.id, skill_id: skill.id)
        if !selected_skill_ids.nil? && selected_skill_ids.include?(skill.id.to_s) 
          teachable.first_or_create
        elsif (!selected_skill_ids.nil? && teachable.exists?)
            Teachable.delete(teachable) 
        elsif teachable.exists?
          Teachable.delete(teachable) 
        end
      end
      if params[:teachable][:data_source]== 'user-form'
        respond_to do |format|
          @surveys = Survey.includes(:category).all
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