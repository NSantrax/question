class QuestsController < ApplicationController
 before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 before_action :load_quest, only: [:show, :edit, :update, :destroy]
 
 def index
   @quests=Quest.all
   @quest=Quest.new
   @quest.attachments.build
 end
 
 def show
   @answer=@quest.answers.build
   @answer.attachments.build
 end
 
 def new
   @quest = Quest.new
   @quest.attachments.build
 end
 
 def create
   @quest = Quest.new(quest_params.merge(user: current_user))
   if @quest.save
     format.js do
       PrivatePub.publish_to "/quests/#{@quest.id}/answers", answer: @answer.to_json
       render nothing: true
     end
   else
     format.js
   end
 end
 
  def edit
  end
  
  def update
    @quest.update(quest_params)
       
  end

  def destroy
    @quest.destroy
    redirect_to quests_path, notice: 'Вопрос удален'
  end
 
  private

  def load_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
  	params.require(:quest).permit(:title, :body, :user, attachments_attributes: [:id, :file, :_destroy])
  end
end
