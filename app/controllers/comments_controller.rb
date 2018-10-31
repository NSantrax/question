class CommentsController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
  
  
  def create
    if params[:answer_id].nil?
      @quest =  Quest.find(params[:quest_id])
      @comment = @quest.comments.build(comment_params) 
      else
        @answer = Answer.find(params[:answer_id])
        @comment = @answer.comments.build(comment_params)  
    end
    respond_to do |format|
      if @comment.save        
        format.js 
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
