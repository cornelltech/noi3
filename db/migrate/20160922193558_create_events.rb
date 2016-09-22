class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :conference_code, :default => ""
      t.string :name, :default => ""
      t.string :logo_path, :default => ""
      t.datetime :date, :default => Time.now

      t.timestamps
    end
  end
end
