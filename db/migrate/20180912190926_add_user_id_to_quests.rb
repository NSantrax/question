class AddUserIdToQuests < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :quests, :user
  end
end
