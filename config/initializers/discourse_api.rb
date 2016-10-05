# This may need to be moved out and instantiated per request or per session. 
# I'm not sure how it performs under concurrency 
DISCOURSE_CONFIG = YAML.load_file("#{Rails.root}/config/discourse.yml")[Rails.env].symbolize_keys!

# $discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
# $discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
# $discourse_client.api_username = DISCOURSE_CONFIG[:api_username]