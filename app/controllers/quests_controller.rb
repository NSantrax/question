class QuestsController < ApplicationController
 before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
 before_action :load_quest, only: [:show, :edit, :update, :destroy]
 before_action :quest_new, only: [:index, :new]
 before_action :answer_build, only: [:show]
 after_action :publish_quest, only: :create
 
 respond_to :html
 respond_to :js, only: [:create, :update]
 
 
 def index  
   respond_with(@quests=Quest.all)   
 end
 
 def show  
   respond_with @quest
 end
 
 def new
   respond_with @quest
 end
 
 def create
   @quest = Quest.new(quest_params.merge(user: current_user))
   respond_to do |format|
     if @quest.save
       format.js do
         PrivatePub.publish_to "/quests", quest: @quest.to_json
         render nothing: true
       end
     else
       format.js
     end
   end
 end
 
  def edit
  end
  
  def update
    @quest.update(quest_params)
    respond_to do |format|
      if @quest.save
        #format.html { render partial: 'quests/quests', layout: false }
        format.json { render json: @quest }
      else
       # format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.json { render json: @quest.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_with(@quest.destroy)
  end
 
  private

  def load_quest
    @quest = Quest.find(params[:id])
  end
  
  def quest_new
    @quest = Quest.new
  end
  
  def answer_build
    @answer=@quest.answers.build
  end

  def quest_params
  	params.require(:quest).permit(:title, :body, :user, attachments_attributes: [:id, :file, :_destroy])
  end
  
end
