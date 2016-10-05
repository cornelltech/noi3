class PagesController < ApplicationController
  protect_from_forgery except: :fetch_sign_up

  def index
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]

    flash[:notice] = "Welcome to NOI"
    category = params['category']
    # @categories = Category.all
    # get categories from discourse API
    @categories = discourse_client.categories
    topics = []
    # get list of latest topics from discourse API
    unless category.nil?
     topics = discourse_client.category_latest_topics(:category_slug => category)
   else
     topics = discourse_client.latest_topics
   end
   @topics = topics.map{ |topic|
	    	# then get each topic in that list in more detail
	    	discourse_client.topic(topic['id'])
	    }
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

  def fetch_edit_user
    session[:return_to] ||= request.referer
  end

end