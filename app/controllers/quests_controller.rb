class QuestsController < ApplicationController
 before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 before_action :load_quest, only: [:show, :edit, :update, :destroy]

 before_action :build_answer, only: :show
 
 authorize_resource
 respond_to :html
 
 def index
   respond_with(@quests=Quest.all)
 end
 
 def show
  respond_with @quest
 end
 
 def new
   respond_with(@quest = Quest.new)
 end
 
 def create
   @quest = Quest.new(quest_params.merge(user: current_user))

   @quest.save 
   respond_with @quest
 end
 
  def edit
  end
  
  def update
    @quest.update(quest_params)

    respond_with @quest

  end
 
  def destroy
    respond_with(@quest.destroy)
  end
 
  private

  def load_quest
    @quest = Quest.find(params[:id])
  end
  

  def build_answer
    @answer=@quest.answers.build
  end
  

  def quest_params
  	params.require(:quest).permit(:title, :body, :user, attachments_attributes: [:id, :file, :_destroy])
  end
  
end
