class ChangeCountryToCountryCode < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :country, :string
    add_column :users, :country_code, :string
  end
end
