class CorrectProjectReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :users_id, :integer
    add_column :projects, :user_id, :integer
  end
end
