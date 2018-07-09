class AnswersController < ApplicationController
  before_action :load_quest, only: [:create]
 
 def new
   @answer = Answer.new
 end
 
 def create
   @answer = @quest.answers.new(answer_params)
   if @answer.save
     redirect_to @quest
   else
     render :new
   end
 end
 
  private

  def load_quest
    @quest = Quest.find(params[:quest_id])
  end
  
  def answer_params
  	params.require(:answer).permit(:quest_id, :body)
  end
end
