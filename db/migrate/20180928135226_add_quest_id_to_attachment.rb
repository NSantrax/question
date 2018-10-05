class AddQuestIdToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :quest_id, :integer
    add_index :attachments, :quest_id
  end
end
