class CreateJoinTableCategoryProject < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :projects do |t|
      # t.index [:category_id, :project_id]
      # t.index [:project_id, :category_id]
    end
  end
end
