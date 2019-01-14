class Api::V1::QuestsController < Api::V1::BaseController

  before_action :load_quest, only: :show
  
  def index
    @quests = Quest.all
    respond_with @quests
  end

  def show
    respond_with @quest
  end
  
  private

  def load_quest
    @quest = Quest.find(params[:id])
  end
end