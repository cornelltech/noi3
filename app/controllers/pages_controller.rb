class PagesController < ApplicationController
  def index
  	category = params['category']
    # @categories = Category.all
    # get categories from discourse API
    @categories = $discourse_client.categories
    topics = []
    # get list of latest topics from discourse API
    unless category.nil?
     topics = $discourse_client.category_latest_topics(:category_slug => category)
    else
	    topics = $discourse_client.latest_topics
	  end
	  @topics = topics.map{ |topic| 
	    	# then get each topic in that list in more detail
	    	$discourse_client.topic(topic['id'])
	    }
  end



  def add_topic
    begin
      $discourse_client.create_topic(
        category: params['topic_category'],
        skip_validations: true,
        auto_track: false,
        title: params['topic-title'],
        raw: params['topic-text']
      )
      redirect_to root_path, notice: "Successfully created topic"
    rescue Exception => e
      puts e.message
      flash[:alert] = @project.errors.full_messages
      render root_path
    end    
  end

  def fetch_sign_up
    # renders sign up page in place with fetch_sign_up.js.erb
  end


end