# This may need to be moved out and instantiated per request or per session. 
# I'm not sure how it performs under concurrency 
discourse_config = YAML.load_file("#{Rails.root}/config/discourse.yml")[Rails.env].symbolize_keys!

$discourse_client = DiscourseApi::Client.new(discourse_config[:url])
$discourse_client.api_key = discourse_config[:api_key]
$discourse_client.api_username = discourse_config[:api_username]