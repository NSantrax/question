class CommentsController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
  belongs_to :question, :answer, polymorphic: true
  
  def create
    @commentable = Commentable.find(params[:quest_id])
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))
 
    respond_to do |format|
      if @answer.save        
        format.js do
          PrivatePub.publish_to "/quests/#{@quest.id}/answers", answer: @answer.to_json
          render nothing: true
        end
      else
        format.js
      end
    end
  end
    
  protected

  def comment_params
    params.require(:comment).permit(:body)
  end
end
