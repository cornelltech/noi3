class CorrectCategoryReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :users_id, :integer
    remove_column :categories, :projects_id, :integer
    add_column :categories, :user_id, :integer
    add_column :categories, :project_id, :integer

  end
end
