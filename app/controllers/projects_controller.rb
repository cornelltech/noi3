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
        flash[:notice] = "Project saved"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
      end
      flash[:alert] = "Project Saved"
    else
      flash[:alert] = @project.errors.full_messages
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    if @project.save
      flash[:alert] = "Project Updated"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
      end
    else
      flash[:alert] = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:alert] = "Project Deleted"
    respond_to do |format|
      format.js {render '/projects/update_projects.js.erb' }
    end
  end

  def fetch_edit_project
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :url, :user_id, language_ids:[], industry_ids: [], skill_area_ids: [])
  end


end