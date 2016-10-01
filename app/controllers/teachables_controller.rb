class TeachablesController < ApplicationController
  def new
    @teachable = Teachable.new
  end

  def create 
    @teachable = Teachable.new
    skill_ids = params[:skill_ids]
    user = User.find(params[:teachable][:user_id])
    skill_ids.each { | skill | Teachable.create(user_id: user.id, skill_id: skill)}
  end

  private

  def teachable_params
    params.require(:teachable).permit(:user_id,:skill_id)
  end

end