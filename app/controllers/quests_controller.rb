class QuestsController < ApplicationController

 before_action :load_quest, only: [:show]
 
 def index
   @quests=Quest.all
 end
 
 def show
 end
 
 def new
   @quest = Quest.new
 end
 
 def create
   @quest = Quest.new(quest_params)
   if @quest.save
     redirect_to @quest
   else
     render :new
   end
 end
 
  private

  def load_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
  	params.require(:quest).permit(:title, :body)
  end
end
