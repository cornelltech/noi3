class CreateTeachables < ActiveRecord::Migration[5.0]
  def change
    create_table :teachables do |t|
      t.references :user
      t.references :skill

      t.timestamps
    end
  end
end
