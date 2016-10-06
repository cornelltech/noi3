class UsersController < ApplicationController

  def index
    # discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    # discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    # discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
    @categories = Category.all
    @industries = Industry.all
    @languages = Language.all
    @events = Event.all

    @params = params;

    @users = User.all
    if params['search_string'] != ""
      @users = @users.fuzzy_search(params['search_string'])
      # projects = Project.basic_search(params['search_string'])
      # @users << projects.map { |project| project.user }
    end
    if params['category'] != ""
      @users = @users.joins(:projects).joins(:categories).distinct.basic_search(:categories => { :name => params[:category] })
    end
    if params['industry'] != ""
      @users = @users.joins(:projects).joins(:industries).distinct.basic_search(:industries => { :name => params[:industry] })
    end
    if params['country'] != "" && params['country'] != nil
      @users = @users.basic_search(country_code: ISO3166::Country.find_country_by_name(params[:country]).alpha2)
      # byebug
    end
    if params['language'] != ""
      @users = @users.joins(:projects).joins(:languages).distinct.basic_search(:languages => { :name => params[:languages] })
    end
    if params['event'] != ""
      @users = @users.joins(:projects).joins(:events).distinct.basic_search(:events => { :name => params[:events] })
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
    respond_to do |format|
      format.js {render '/users/update_events.js.erb' }
    end
  end

  def remove_event
    user = current_user
    event = Event.find(params["event_id"])
    user.events.delete(event)
    respond_to do |format|
      format.js {render '/users/update_events.js.erb' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar,:username, :picture_path, :first_name, :last_name, :position, :organization, :organization_type, :country_code, :city, :language, :industry_ids => [], :language_ids => [], :event_ids => [])
  end

end
