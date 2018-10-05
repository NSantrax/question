class AnswersController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 
  def create
    @quest = Quest.find(params[:quest_id])
    @answer = @quest.answers.build(answer_params.merge(user: current_user))
    
    respond_to do |format|
      if @answer.save
        format.html { render partial: 'quests/answers', layout: false }
      else
        format.html { render text: @answer.errors.full_messages.join("\n") }
      end
    end
  end
  
  def update
     @answer = Answer.find(params[:id])
     @answer.update(answer_params)
     @quest = @answer.quest
  end

  def destroy
    @answer = Answer.find(params[:id])
    @quest = @answer.quest
    @answer.destroy
    redirect_to quest_path(@quest), notice: 'Ответ удален'
  end
 
  private


  def answer_params
  	params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
