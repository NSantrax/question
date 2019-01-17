class Api::V1::QuestsController < Api::V1::BaseController

  before_action :load_quest, only: :show

  def index
    @quests = Quest.all
    respond_with(@quests, each_serializer: ListQuestSerializer)
  end

  def show
    respond_with(@quest, serializer: QuestSerializer)
  end

  def create
    @quest = Quest.create(quest_params.merge(user: current_user)) 
  end
 
  protected

  def load_quest
    @quest = Quest.find(params[:id])
  end
end