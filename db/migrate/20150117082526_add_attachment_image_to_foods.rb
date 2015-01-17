class AddAttachmentImageToFoods < ActiveRecord::Migration
  def self.up
    change_table :foods do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :foods, :image
  end
end
