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
    # byebug
    @project.assign_attributes(project_params)
    if @project.save
        flash.now[:notice] = "Project Saved"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
      end
    else
      flash.now[:alert] = @project.errors.full_messages
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    if @project.save
      flash.now[:notice] = "Project Updated"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
      end
    else
      flash.now[:alert] = @project.errors.full_messages
      render :edit
    end
  end

  def update_subcategory_dropdown
    category = Category.find(params[:category_id])
    @skill_areas = SkillArea.where(category_id: category.id)
    respond_to do |format|
      format.js {render '/projects/update_subcategory_dropdown.js.erb'}
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash.now[:notice] = "Project Deleted"
    respond_to do |format|
      format.js {render '/projects/update_projects.js.erb' }
    end
  end

  def fetch_edit_project
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :url, :user_id, category_ids:[], language_ids:[], industry_ids: [], skill_area_ids: [])
  end


end