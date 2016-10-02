class RemoveDoorKeeper < ActiveRecord::Migration[5.0]
  def change
  	drop_table :oauth_applications
  	drop_table :oauth_access_grants
  	drop_table :oauth_access_tokens
  end
end
