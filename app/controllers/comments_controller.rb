class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parents, only: :create
  before_action :load_quest, only: :destroy
  #authorize_resource
  respond_to :js
   
  def create
    respond_with(@comment = @parent.comments.create(comment_params.merge(user: current_user)))
  end

  def destroy
   respond_with(@comment.destroy, :location => quest_path(@quest), notice: 'Ответ удален')
  end
    
  protected
  
  def load_parents
    @parent =  Quest.find(params[:quest_id]) if params[:quest_id]
    @parent ||= Answer.find(params[:answer_id])
  end

  def load_quest
    @comment = Comment.find(params[:id])
    @comment.commentable.is_a?(Quest)? @quest = @comment.commentable : @quest = @comment.commentable.quest
    
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
