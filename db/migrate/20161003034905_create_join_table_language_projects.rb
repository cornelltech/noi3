class CreateJoinTableLanguageProjects < ActiveRecord::Migration[5.0]
  def change
    create_join_table :languages, :projects do |t|
      # t.index [:language_id, :project_id]
      # t.index [:project_id, :language_id]
    end
  end
end
