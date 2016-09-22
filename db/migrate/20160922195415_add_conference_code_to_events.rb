class AddConferenceCodeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :conference_code, :string, :default => ""
  end
end
