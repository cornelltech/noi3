class LearnablesController < ApplicationController
  def new
    @learnable = Learnable.new
  end

  def create 
    @learnable = Learnable.new
    skill_ids = params[:skill_ids]
    user = User.find(params[:learnable][:user_id])
    unless skill_ids == nil
      skill_ids.each { | skill | Learnable.create(user_id: user.id, skill_id: skill)}
    end
  end

  private

  def learnable_params
    params.require(:learnable).permit(:user_id,:skill_id)
  end

end