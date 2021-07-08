class AnswersController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
  before_action :load_answer, only: [:update, :destroy]
  after_action :publish_answer, only: :create
  

  respond_to :js, only: :create
  respond_to :json, only: :update

 
  def create
    @quest = Quest.find(params[:quest_id])
    respond_with(@answer = @quest.answers.create(answer_params.merge(user: current_user)))
  end
  
  def update
    @answer.update(answer_params)
    respond_to do |format|

      if @answer.save
        #format.html { render partial: 'quests/answers', layout: false }
        format.json { render json: @answer }
      else
       # format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy

   respond_with(@answer.destroy, :location => quest_path(@quest), notice: 'Ответ удален')

  end
 
  private
  
  def load_answer
    @answer = Answer.find(params[:id])
    @quest = @answer.quest
  end
  
  def publish_answer
    PrivatePub.publish_to "/quests/#{@quest.id}/answers", answer: @answer.to_json if @answer.valid?
  end

  def answer_params
  	params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy], comments_attributes: [:id, :body, :_destroy])
  end
end

