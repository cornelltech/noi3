if Rails.env.test?
  FACEBOOK_CONFIG = {:app_id=>"secrets", :secret=>"secrets"}
else
  FACEBOOK_CONFIG = YAML.load(ERB.new(File.read("#{::Rails.root}/config/facebook.yml.erb")).result)[::Rails.env].symbolize_keys!
end