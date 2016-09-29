class CreateJoinTableIndustryProject < ActiveRecord::Migration[5.0]
  def change
    create_join_table :industries, :projects do |t|
      # t.index [:industry_id, :project_id]
      # t.index [:project_id, :industry_id]
    end
  end
end
