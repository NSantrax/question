class Api::V1::AnswersController < Api::V1::BaseController

  before_action :load_quest, only: [:index, :create]
  before_action :load_answer, only: [:show, :update, :destroy]
  def index
    @answers = @quest.answers
    respond_with @answers
  end

  def show
    respond_with(@answer, serializer: ListAnswerSerializer)
  end

  def create
    #@quest = Quest.find(params[:id])
    @answer = @quest.answers.new(answer_params.merge(user: current_resource_owner))
    if @answer.save
      respond_with @answer
    else
      #render @answer.errors.messages.to_json
    end
  end
 
  protected
  def load_answer
    @answer = Answer.find(params[:id])
    @quest = @answer.quest
  end

  def load_quest
    @quest = Quest.find(params["quest_id"])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy], comments_attributes: [:id, :body, :_destroy])
  end
end