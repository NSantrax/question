class QuestsController < ApplicationController
 before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 before_action :load_quest, only: [:show, :edit, :update, :destroy]
 
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
     redirect_to @quest, notice: 'Вопрос сохранен'
   else
     render :new
   end
 end
 
  def edit
  end
  
  def update
      if @quest.update(quest_params)
        redirect_to quests_path, notice: 'Вопрос изменен'
      else
        render :edit
      end
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
  	params.require(:quest).permit(:title, :body)
  end
end
