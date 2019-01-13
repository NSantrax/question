class Api::V1::QuestsController < Api::V1::BaseController


  def index
    @quests = Quest.all
    respond_with @quests.to_json(include: :answers)
  end

end