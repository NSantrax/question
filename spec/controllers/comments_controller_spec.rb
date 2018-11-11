require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:user){create :user}
  let!(:quest) {create(:quest, user: user)}
  let(:answer){create(:answer, quest: quest, user: user)}

  describe 'POST #create' do
    user_sign_in
      
    it 'load quest if parent is quest' do
      post :create, comment: attributes_for(:comment), quest_id: quest.id, format: :js
      expect(assigns(:parent)).to eq quest
    end
      
    it 'load answer if parent is answer' do
       post :create, comment: attributes_for(:comment), answer_id: answer.id, format: :js
       expect(assigns(:parent)).to eq answer
     end
   end
     
   
end

