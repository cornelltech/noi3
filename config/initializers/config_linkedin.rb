LINKEDIN_CONFIG = YAML.load(ERB.new(File.read("#{::Rails.root}/config/linkedin.yml.erb")).result)[::Rails.env].symbolize_keys!
