FACEBOOK_CONFIG = YAML.load(ERB.new(File.read("#{::Rails.root}/config/facebook.yml.erb")).result)[::Rails.env].symbolize_keys!
