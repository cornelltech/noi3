class PagesController < ApplicationController
  protect_from_forgery except: :fetch_sign_up

  def index
    @params = params
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]

    flash[:notice] = "Welcome to NOI"
    category = params['category']
    # @categories = Category.all
    # get categories from discourse API
    @categories = discourse_client.categories.select{ |c| c['name'] != 'Staff' && c['name'] != 'Lounge' && c['name'] != 'Site Feedback' }
    topics = []
    # get list of latest topics from discourse API
    unless category.nil? || category == ""

      topics = discourse_client.category_latest_topics(:category_slug => category.parameterize)
    else
      topics = discourse_client.latest_topics
    end
    @topics = topics.map{ |topic|
      # if topic.category['name'] != 'Staff' && topic.category['name'] != 'Lounge' && topic.category['name'] != 'Site Feedback'
	    	# then get each topic in that list in more detail
	    	discourse_client.topic(topic['id'])
      # end
    }.paginate(:page => params[:page], :per_page => 10)
  end

  def add_topic
    begin
      discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
      discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
      discourse_client.api_username = current_user.username

      discourse_client.create_topic(
        category: params['topic-category'],
        skip_validations: true,
        auto_track: false,
        title: params['topic-title'],
        raw: params['topic-text']
        )
      redirect_to root_path, notice: "Successfully created topic"
    rescue Exception => e
      puts e.message
      flash[:alert] = "Error creating topic"
      render root_path
    end
  end

  # render devise views in panel
  def fetch_sign_up
  end

  def fetch_log_in
  end

  def fetch_forgot_password
  end

  def fetch_edit_account
  end

  def delete_account_success
  end

  def fetch_edit_user
    @user_work_fields = current_user.industries.pluck(:id)
    @user_languages = current_user.languages.pluck(:id)
    session[:return_to] ||= request.referer
  end

end
