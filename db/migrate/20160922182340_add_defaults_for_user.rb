class AddDefaultsForUser < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :picture_path, :string, :default => ""
    change_column :users, :first_name, :string, :default => ""
    change_column :users, :last_name, :string, :default => ""
    change_column :users, :position, :string, :default => ""
    change_column :users, :organization, :string, :default => ""
    change_column :users, :organization_type, :string, :default => ""
    change_column :users, :city, :string, :default => ""
    change_column :users, :country, :string, :default => ""
    change_column :projects, :title, :string, :default => ""
    change_column :projects, :description, :string, :default => ""
  end

  def down
    change_column :users, :picture_path, :string, :default => nil
    change_column :users, :first_name, :string, :default => nil
    change_column :users, :last_name, :string, :default => nil
    change_column :users, :position, :string, :default => nil
    change_column :users, :organization, :string, :default => nil
    change_column :users, :organization_type, :string, :default => nil
    change_column :users, :city, :string, :default => nil
    change_column :users, :country, :string, :default => nil
    change_column :projects, :title, :string, :default => nil
    change_column :projects, :description, :string, :default => nil
  end
end
