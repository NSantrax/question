class AddQuestIdToAnswers < ActiveRecord::Migration[5.2]
  def change
   add_belongs_to :answers, :quest    
  end
end
