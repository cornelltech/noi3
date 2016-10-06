class TeachablesController < ApplicationController
  def new
    @teachable = Teachable.new
  end

  def create 
    @teachable = Teachable.new
    skill_ids = params[:skill_ids]
    user = User.find(params[:teachable][:user_id])
    unless skill_ids == nil
      skill_ids.each { | skill | Teachable.where(user_id: user.id, skill_id: skill).first_or_create}
        flash[:notice] = "Skills saved!"
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