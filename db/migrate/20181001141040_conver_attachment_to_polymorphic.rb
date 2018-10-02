class ConverAttachmentToPolymorphic < ActiveRecord::Migration[5.2]
  def change
    remove_index :attachments, :quest_id
    rename_column :attachments, :quest_id, :attachmentable_id
    add_index :attachments, :attachmentable_id

    add_column :attachments, :attachmentable_type, :string
    add_index :attachments, :attachmentable_type
  end
end
