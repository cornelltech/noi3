class CreateSkillAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :skill_areas do |t|
      t.string :name, default: ""
      t.string :long_name, default: ""
      t.references :category

      t.timestamps
    end
  end
end
