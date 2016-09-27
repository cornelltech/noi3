class CreateSkillAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :skill_areas do |t|
      t.string :name, default: ""

      t.timestamps
    end
  end
end
