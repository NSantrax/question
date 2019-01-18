class Api::V1::QuestsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :load_quest, only: :show

  def index
    @quests = Quest.all
    respond_with(@quests, each_serializer: ListQuestSerializer)
  end

  def show
    respond_with(@quest, serializer: QuestSerializer)
  end

  def create
    @quest = Quest.new(quest_params.merge(user: current_user))
    if @quest.save
      respond_with @quest
    else
      render @quest.error.message.to_json
    end

  end
 
  protected

  def load_quest
    @quest = Quest.find(params[:id])
  end
end