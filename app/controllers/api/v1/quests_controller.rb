class Api::V1::QuestsController < Api::V1::BaseController


  def index
    @quests = Quest.all
    respond_with @quests
  end

end