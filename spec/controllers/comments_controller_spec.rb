require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  
  let!(:user){create :user}
  let!(:quest) {create(:quest, user: user)}
  let(:answer){create(:answer, quest: quest, user: user)}

  describe 'POST #create' do
    user_sign_in 
    it 'load quest if parent is quest' do
      post :create, params: {quest_id: quest.id, comment: attributes_for(:comment)}, format: :js
      expect(assigns(:parent)).to eq quest
    end
      
    it 'load answer if parent is answer' do
      post :create, params: {answer_id: answer.id, comment: attributes_for(:comment)}, format: :js
      expect(assigns(:parent)).to eq answer
    end
  end
     
   
end

