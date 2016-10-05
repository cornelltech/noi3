class TeachablesController < ApplicationController
  def new
    @teachable = Teachable.new
  end

  def create 
    @teachable = Teachable.new
    skill_ids = params[:skill_ids]
    user = User.find(params[:teachable][:user_id])
    unless skill_ids == nil
      skill_ids.each do| skill | 
        new_teachable = Teachable.where(user_id: user.id, skill_id: skill).first_or_create
      end
    end
  end

  private

  def teachable_params
    params.require(:teachable).permit(:user_id,:skill_id)
  end

end