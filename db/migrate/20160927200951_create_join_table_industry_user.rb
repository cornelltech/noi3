class CreateJoinTableIndustryUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :industries, :users do |t|
      # t.index [:industry_id, :user_id]
      # t.index [:user_id, :industry_id]
    end
  end
end
