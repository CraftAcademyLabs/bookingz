class AddAttachmentAttachmentToFacilties < ActiveRecord::Migration[5.1]
  def self.up
    change_table :facilities do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :facilities, :attachment
  end
end
