class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parents
  after_action :publish_comment
  respond_to :js
  
  def create
      respond_with(@comment = @parent.comments.create(comment_params))
  end
    
  protected
  
  def load_parents
    @parent =  Quest.find(params[:quest_id]) if params[:quest_id]
    @parent ||= Answer.find(params[:answer_id])
  end
  
  def publish_comment
    channel = "/quests/#{@parent.id}/comments" if params[:quest_id]
    channel ||= "/quests/#{@parent.quest.id}/answers/#{@parent.id}/comments" 
    PrivatePub.publish_to channel, comment: @comment.to_json
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
