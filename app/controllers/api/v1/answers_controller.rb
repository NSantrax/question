class Api::V1::AnswersController < Api::V1::BaseController

  before_action :load_quest, only: [:create, :index]
  before_action :load_answer, only: [:show, :update]
  def index
    @answers = @quest.answers
    respond_with @answers
  end

  def show
    respond_with(@answer, serializer: ListAnswerSerializer)
  end

  def create
    @answer = @quest.answers.build(answer_params.merge(user: current_user)) 
  end
 
  protected
  def load_answer
    @answer = Answer.find(params[:id])
    @quest = @answer.quest
  end

  def load_quest

    @quest = Quest.find(params["quest_id"])
  end
end