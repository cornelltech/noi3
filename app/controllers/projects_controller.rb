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
    @project = Project.new(params[:id])
    @project.assign_attributes(project_params)
    @project.url = format_url(@project.url)

    if @project.save
      flash[:notice] = "Project Saved"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
        format.html {
          flash[:notice] = "Your project has been created."
          redirect_to users_path
          }
      end
    else
      if @project.title == ""
        flash.now[:title_alert] = "Please enter a title for your project"
      end
      if @project.description == ""
        flash.now[:description_alert] = "Please enter a description for your project"
      end

      flash[:alert] = @project.errors.full_messages

      respond_to do |format|
        format.js {render '/projects/fetch_project_create_error.js.erb' }
        format.html {
          flash[:notice] = "Your project has not been created."
          redirect_to users_path
          }
      end
    end
  end

  def format_url(url)
    return if url.blank?

    url = "http://#{url}" unless url[/^https?/]
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    @project.url = format_url(@project.url)
    if @project.save
      flash.now[:notice] = "Project Updated"
      respond_to do |format|
        format.js {render '/projects/update_projects.js.erb' }
        format.html {
          flash.now[:notice] = "Your project has been updated."
          redirect_to users_path
          }
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
    params.require(:project).permit(:title, :description, :url, :document, :user_id, category_ids:[], language_ids:[], industry_ids: [], skill_area_ids: [])
  end


end
