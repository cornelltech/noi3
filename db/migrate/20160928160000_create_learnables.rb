class CreateLearnables < ActiveRecord::Migration[5.0]
  def change
    create_table :learnables do |t|
      t.references :user
      t.references :skill

      t.timestamps
    end
  end
end
