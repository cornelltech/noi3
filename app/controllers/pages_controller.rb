class PagesController < ApplicationController
  protect_from_forgery except: :fetch_sign_up

  def index
    @params = params
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]

    category = params['category']
    @categories = discourse_client.categories.select{ |c| c['name'] != 'Staff' && c['name'] != 'Lounge' && c['name'] != 'Site Feedback' }.sort_by {|c|c["name"]}
    topics = []
    # get list of latest topics from discourse API
    unless category.nil? || category == ""
      # topics = discourse_client.category_latest_topics(:category_slug => category.parameterize)
      @users = User.all
    else
      topics = discourse_client.get("posts")['body']["latest_posts"]
      usernames = topics.pluck("username").uniq!
      @users = User.where(username: usernames)
    end

    if params["post-search"] != "" && !params["post-search"].nil? 
      post_search_string = params["post-search"].split(' ').join('+')
      filtered_posts = discourse_client.get("search/?q=#{post_search_string}")['body']['posts']
      @topics = filtered_posts.map{ |topic|
        discourse_topic = discourse_client.topic(topic['topic_id'])
        user = @users.find {|u| u.username == topic["username"]}
        discourse_topic['ext_user_id'] = user.id if !user.nil?
        discourse_topic
        }.paginate(:page => params[:page], :per_page => 10)
    elsif params["category"] != "" && !params["category"].nil? 
      category = params['category'].gsub("General","Uncategorized")
      category_posts = discourse_client.get("c/#{category.parameterize}")['body']['topic_list']['topics']
      @topics = category_posts.map{ |topic|
        discourse_topic = discourse_client.topic(topic['id'])
        user = @users.find {|u| u.username == topic["last_poster_username"]}
        discourse_topic['ext_user_id'] = user.id if !user.nil?
        discourse_topic
        }.paginate(:page => params[:page], :per_page => 10)
    else
      @topics = topics.map { |topic|
        user = @users.find {|u| u.username == topic["username"]}
        topic['ext_user_id'] = user.id if !user.nil?
        topic
        }.paginate(:page => params[:page], :per_page => 10)
      end
    end


  def add_topic
    begin
      discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
      discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
      discourse_client.api_username = current_user.username

      discourse_client.create_topic(
        category: params['topic-category'],
        skip_validations: false,
        auto_track: false,
        title: params['topic-title'],
        raw: params['topic-text']
        )


      respond_to do |format|
        flash.now[:alert] = "Successfully created topic."
        format.html { 
          redirect_to root_path
        }
        format.js { 
          render js: "window.location = '#{root_path}'"
        }
      end
    rescue Exception => e
      respond_to do |format|
        asked_question = {category: params['topic-category'],title: params['topic-title'],raw: params['topic-text']}

        flash.now[:alert] = "Error creating topic."
        if e.message != ""
          flash.now[:errors] = parse_discourse_errors(e.message)
        end

        flash.now[:alert] << get_discourse_errors(asked_question)

        format.html { 
          redirect_to root_path
        }
        format.js { 
          render :file => "/pages/fetch_topic_errors.js.erb" 
        }
      end
    end
  end

  def parse_discourse_errors(message)
    message_split = message.split('=>')
    discourse_errors = message_split[2].delete("}").delete('[').delete(']').delete('\"')
    discourse_errors.gsub("Title", "Question") 
  end

  def get_discourse_errors(content)
    errors = ""
    content[:title] == "" ? errors << "Question cannot be blank. " : ""
    content[:raw] == "" ? errors += "Question detail cannot be blank. " : ""
    errors.to_s
  end

  def reply_to
    begin
      discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
      discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
      discourse_client.api_username = current_user.username

      puts "reply_to post #{params['topic_id']}/#{params['reply_to_post_number']}, category #{params['category']}: #{params['reply']}"
      discourse_client.post( "posts/", { category: params['category'], topic_id: params['topic_id'], reply_to_post_number: params['reply_to_post_number'], raw: params['reply'] } )

      respond_to do |format|
        format.js { render inline: "location.reload();" }
      end
    rescue Exception => e
      respond_to do |format|
        flash.now[:reply_error] = "Error creating post."
        if e.message != ""
          flash.now[:reply_error] = parse_discourse_errors(e.message)
        end
        format.js
      end
    end
  end

  # render devise views in panel

  def fetch_create_post
  end

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
    # session[:return_to] ||= request.referer
  end

end
