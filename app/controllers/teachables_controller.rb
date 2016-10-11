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
# byebug
    category = Category.find(params[:teachable][:category_id]) 
    # find current skills from user
   
    current_skills = user.teachables.pluck(:skill_id)
    # find current skills in this category

    skills_in_cat = user.teachables.includes(:category).select {|item| item.skill.category == category }
    # get all the skills from the category
    # byebug
    category_skills = category.skills
puts "CURRENT SKILLS"
p current_skills
    category_skills.each do | skill |
      # byebug
      teachable = Teachable.where(user_id: user.id, skill_id: skill.id)
        if !selected_skill_ids.nil? && selected_skill_ids.include?(skill.id.to_s) 
          teachable.first_or_create
        elsif (!selected_skill_ids.nil? && teachable.exists?)
            Teachable.delete(teachable) 
        elsif teachable.exists?
          Teachable.delete(teachable) 
        end

      end
puts "NEW SKILLS ARRAY"
p user.teachables.pluck(:skill_id)
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