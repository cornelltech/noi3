class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    # discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    # discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    # discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
    @categories = Category.all
    @skill_areas = SkillArea.pluck(:name).uniq!
    @industries = Industry.all
    @languages = Language.all
    @events = Event.all

    @params = params;

    @active_filters = get_active_filters(params)

    # Sort all users before applying filters
    if params[:sort] && params[:direction]
      sort_query = params[:sort] + " " + params[:direction]
     @users = User.order(sort_query)
    else
      # default sort by created_at
      @users = User.all
    end

    @users = @users.paginate(:page => params[:page], :per_page => 5)
    if params['search_string'] != ""
      @users = @users.fuzzy_search(params['search_string']).paginate(:page => params[:page], :per_page => 5)
      # projects = Project.basic_search(params['search_string'])
      # @users << projects.map { |project| project.user }
    end
    if params['industry'] && params['industry'] != ""
      @users = @users.joins(:industries).distinct.basic_search(:industries => { :name => params[:industry] }).paginate(:page => params[:page], :per_page => 5)
    end
    if params['country'] && params['country'] != "" && params['country'] != nil
      @users = @users.basic_search(country_code: ISO3166::Country.find_country_by_name(params[:country]).alpha2).paginate(:page => params[:page], :per_page => 5)
      # byebug
    end
    if params['language'] && params['language'] != ""
      @users = @users.joins(:languages).distinct.basic_search(:languages => { :name => params[:language] }).paginate(:page => params[:page], :per_page => 5)
      # byebug
    end
    if params['event'] && params['event'] != ""
      # puts 'DEBUG-------------'
      # puts params[:event]
      # puts @users.joins(:events).distinct.basic_search(:events => { :name => params[:event] })
      @users = @users.joins(:events).distinct.basic_search(:events => { :name => params[:event] }).paginate(:page => params[:page], :per_page => 5)
      # byebug
    end
    if params['skill_area'] && params['skill_area'] != "" && params['category'] == ""
      # byebug
      skill_area = SkillArea.where(name: params['skill_area'].downcase).first
      @users = @users.joins(:skill_areas).where('skill_area_id=?',skill_area.id).paginate(:page => params[:page], :per_page => 5)
    end
    if params['category'] && params['category'] != ""
      # currently searching by category of users skills is not working, need to figure out correct query
      # @users = @users.joins(:projects).joins(:categories).distinct.basic_search(:categories => { :name => params[:category] })
      category = Category.where(name: params['category'].downcase).first
      skill_area = SkillArea.where(name: params['skill_area'].downcase,category_id: category.id).first
      if category && skill_area
        @users = @users.joins(:skill_areas).where('skill_area_id=?',skill_area.id).paginate(:page => params[:page], :per_page => 5)
      elsif category
        # skill_ids = Skill.where(category_id: category.id).pluck(:id)
        # user_ids = Teachable.where(skill_id: skill_ids).pluck(:user_id).uniq
        # @users = @users.where(id: user_ids).paginate(:page => params[:page], :per_page => 5)
        @users = @users.joins(:categories).where('category_id=?',category.id).paginate(:page => params[:page], :per_page => 5)

      else
        @users = []
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    @user = User.find(params[:id])
     # authorize! :update, @user
     respond_to do |format|
       if @user.update(user_params)
         sign_in(@user == current_user ? @user : current_user)
         format.html { redirect_to session.delete(:return_to), notice: 'Your profile was successfully updated.' }
         format.js { render :file => "/users/fetch_update_success.js.erb" }
       else
        flash.now[:errors] = @user.errors.full_messages
        format.html { render action: 'edit' }
        format.js { 
          render :file => "/users/fetch_update.js.erb" 
        }
       end
     end
   end

   # GET/PATCH /users/:id/finish_signup
   def finish_signup
    @user = User.find(params[:id])
     # authorize! :update, @user
     if request.patch? && params[:user] && params[:user][:username]
       if @user.update(user_params)
         @user.skip_reconfirmation!
         sign_in(@user)
         redirect_to root_path
       else
         @show_errors = true
       end
     end
   end

   def delete_oauth_provider
    provider = params[:format]
    current_user.identities.where(provider: provider).first.delete
    redirect_to root_path
   end


  def show
    @user = User.find(params[:id])
    @events = Event.all
    @projects = []

    @user.projects.each do | project |
      project_with_tags = {project: project,tags:'', industries:''}
      project_with_tags[:tags] = project.format_categories
      project_with_tags[:industries] = project.industries.map {| industry | industry.name }.sort.join(', ')
      @projects.push(project_with_tags)
    end
  end

  def fetch_user
    @selected = User.find(params[:user_id])
    respond_to do | format |
      format.js
    end
  end

  def fetch_user_learning_menu
    @surveys = Survey.includes(:category).all
  end

  def fetch_user_teaching_menu
    @surveys = Survey.includes(:category).all
  end

  def fetch_learning_survey
    @user = current_user
    @survey = Survey.includes(:category).find(params[:survey_id])
    @user_skills_in_cat = @user.learnables.includes(:skill,:category).select {|item| item.skill.category == @survey.category }.pluck(:skill_id)
    @skill_areas = @survey.category.skill_areas.includes(:skills).map {|sa| sa}.uniq!
    respond_to do |format|
      format.js
    end
  end

  def fetch_teaching_survey
    @user = current_user
    @survey = Survey.includes(:category).find(params[:survey_id])
    @user_skills_in_cat = @user.teachables.includes(:skill, :category).select {|item| item.skill.category == @survey.category }.pluck(:skill_id)
    @skill_areas = @survey.category.skill_areas.includes(:skills).map {|sa| sa }.uniq!
    respond_to do |format|
      format.js
    end
  end

  def add_and_remove_events
    user = current_user
    event_ids = params['event_ids']
    event_ids.each do | event_id |
      event = Event.find(event_id)
      if !user.events.include?(event)
        user.events << Event.find(event)
      else
        user.events.delete(event)
      end
    end
    respond_to do |format|
      format.js {render '/users/update_events.js.erb' }
    end
  end


  def get_active_filters(params)
    active_filters = {}
    active_filters[:search_string] = params[:search_string]
    active_filters[:category] = params[:category]
    active_filters[:skill_area] = params[:skill_area]
    active_filters[:industry] = params[:industry]
    active_filters[:country] = params[:country]
    active_filters[:language] = params[:language]
    active_filters[:event] = params[:event]
    active_filters.delete_if { |key, value| value.blank? }
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :username, :picture_path, :first_name, :last_name, :position, :organization, :organization_type, :country_code, :city, :language, :industry_ids => [], :language_ids => [], :event_ids => [])
  end

  def sort_column
    @users.column_names.include?(params[:sort]) ? params[:sort] : ""
  end

  def sort_direction
    ["asc","desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
