class InstallTrigram < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS pg_trgm;") if ENV['RAILS_ENV'] == 'production'
  end

  def self.down
    ActiveRecord::Base.connection.execute("DROP EXTENSION pg_trgm;") if ENV['RAILS_ENV'] == 'production'
  end
end
