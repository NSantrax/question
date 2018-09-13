class AnswersController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 
  def create
    @quest = Quest.find(params[:quest_id])
    @answer = @quest.answers.create(answer_params.merge(user: current_user))
  end
  
  def update
     @answer = Answer.find(params[:id])
     @answer.update(answer_params)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to quests_path, notice: 'Ответ удален'
  end
 
  private


  def answer_params
  	params.require(:answer).permit(:body)
  end
end
