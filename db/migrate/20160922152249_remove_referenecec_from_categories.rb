class RemoveReferenececFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :user_id, :integer
    remove_column :categories, :project_id, :integer
  end
end
