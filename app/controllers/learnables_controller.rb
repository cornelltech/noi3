class LearnablesController < ApplicationController
  def new
    @learnable = Learnable.new
  end

  def create 

    @learnable = Learnable.new
    # byebug
    skill_ids = params[:skill_ids]
    user = User.find(params[:learnable][:user_id])
    unless skill_ids == nil
      skill_ids.each { | skill | Learnable.where(user_id: user.id, skill_id: skill).first_or_create}
        flash[:notice] = "Skills saved!"
    end
        respond_to do |format|
          @surveys = Survey.all
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