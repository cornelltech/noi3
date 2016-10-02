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



end