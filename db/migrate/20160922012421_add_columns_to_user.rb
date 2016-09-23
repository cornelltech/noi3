class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :picture_path, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :position, :string
    add_column :users, :organization, :string
    add_column :users, :organization_type, :string
  end
end
