class AddAttachmentDocumentToProjects < ActiveRecord::Migration[5.0]
  def self.up
    change_table :projects do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :projects, :document
  end
end
