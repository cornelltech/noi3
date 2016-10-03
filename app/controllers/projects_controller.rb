class ProjectsController < ApplicationController

  def index
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create 
    @project = Project.new
    @project.assign_attributes(project_params)
    if @project.save
      flash[:alert] = "Project Saved"
    else
      flash[:alert] = @project.errors.full_messages
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    if @project.save
      redirect_to root_path, notice: "Successfully edited account"
    else
      flash[:alert] = @project.errors.full_messages
      render :edit
    end
  end

  def project_params
    params.require(:project).permit(:title, :description, :url, :user_id, language_ids:[], industry_ids: [], skill_area_ids: [])
  end


end