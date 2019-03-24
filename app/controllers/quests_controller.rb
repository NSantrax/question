class QuestsController < ApplicationController
 before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 before_action :load_quest, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe]

 before_action :build_answer, only: :show
 
 #authorize_resource
 respond_to :html
 
 def index
   respond_with(@quests=Quest.all)
 end
 
 def show
  #fresh_when last_modified: @quest.updated_at

  respond_with @quest
 end
 
 def new
   authorize Quest
   respond_with(@quest = Quest.new)
 end
 
 def create
   authorize Quest
   @quest = Quest.new(quest_params.merge(user: current_user))

   @quest.save 
   respond_with @quest
 end
 
  def edit
  end
  
  def update
    authorize @quest
    @quest.update(quest_params)

    respond_with @quest

  end
 
  def destroy
    authorize @quest
    respond_with(@quest.destroy)
  end

  def subscribe
    unless @quest.subscriptions.where(user: current_user).present?
      @quest.subscriptions.create(user: current_user)
        #flash[:success] = "User subscribed"
      redirect_to @quest
    end
  end

  def unsubscribe
    @quest.subscriptions.find_by(user: current_user).delete
        #flash[:success] = "User subscribed"
    redirect_to @quest
    
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
