class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :short_name, default: ""
      t.string :description, default: ""
      t.belongs_to :category, default: ""
      t.belongs_to :skill_area, default: ""

      t.timestamps
    end
  end
end
