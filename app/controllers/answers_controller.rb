class AnswersController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
  before_action :load_quest, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_answer, only: [:edit, :show, :update, :destroy]
 
 
 def create
   @quest = Quest.find(params[:quest_id])
   @answer = @quest.answers.create(answer_params)
   if @answer.save
     redirect_to quest_path(@answer.quest), notice: 'Ответ сохранен'
     else redirect_to quest_path(@answer.quest), notice: 'Ответ не сохранен'
   end
 end
 
 def edit
 end
  
  def update
      if @quest.answers.update(answer_params)
        redirect_to quests_path, notice: 'Ответ изменен'
      else
        render :edit
      end
  end

  def destroy
    @answer.destroy
    redirect_to quests_path, notice: 'Ответ удален'
  end
 
  private

  def load_quest
    @quest = Quest.find(params[:quest_id])
  end
  
  def load_answer
    @answer = Answer.find(params[:answer_id])
  end
  
  def answer_params
  	params.require(:answer).permit(:body)
  end
end
