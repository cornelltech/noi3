class CreateJoinTableProjectSkillArea < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :skill_areas do |t|
      # t.index [:project_id, :skill_area_id]
      # t.index [:skill_area_id, :project_id]
    end
  end
end
