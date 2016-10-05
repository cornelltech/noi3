class UsersController < ApplicationController

  def index
    # discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    # discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    # discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
    @categories = Category.all

    if params['search']
      @users = User.basic_search(params['search_string'])      
      # projects = Project.basic_search(params['search_string'])      
      # @users << projects.map { |project| project.user }      
    elsif params['category']
      @users = User.joins(:projects).joins(:categories).basic_search(:categories => { :name => params[:category] })
    else
      @users = User.all
    end
    # @expertise = User.first.format_expertise
    # @main_expertise = User.first.format_main_expertise

  end

  def edit
    @user = User.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      # redirect_to :action => :index
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @expertise = @user.format_expertise
    @events = Event.all
    @projects = []

    @user.projects.each do | project |
      project_with_tags = {project: project,tags:'', industries:''}
      project_with_tags[:tags] = project.format_categories
      project_with_tags[:industries] = project.industries.map {| industry | industry.name }.sort.join(', ')
      @projects.push(project_with_tags)
    end

    # respond_to do |format|
    #   format.html
    #   format.json { render json: {:user => @user, :industries => @user.industries, :expertise => @user.format_expertise, :main_expertise => @user.format_main_expertise, :projects => @projects, :events => @user.events, :categories => @user.categories}}
    # end
  end

  def fetch_user
    @selected = User.find(params[:user_id])
    respond_to do | format |
      format.js
    end
  end

  def add_event
    user = current_user
    # byebug
    event_ids = params['event_ids']
    event_ids.each do | event_id |
      event = Event.find(event_id)
      if !user.events.include?(event)
        user.events << Event.find(event)
      end
    end
  end

  def remove_event
    user = current_user
    event = Event.find(params["event_id"])
    user.events.delete(event)
  end

  private

  def user_params
    params.require(:user).permit(:username, :picture_path, :first_name, :last_name, :position, :organization, :organization_type, :country_code, :city, :language, :industry_ids => [], :language_ids => [], :event_ids => [])
  end

end
