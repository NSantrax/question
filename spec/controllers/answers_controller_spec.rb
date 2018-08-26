require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:quest) {create(:quest)}
  
 
  describe 'GET #new' do
     user_sign_in
     before {get :new, params:{quest_id: quest}}
     it 'assigns a new Answer to @answer' do
       expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
  
  describe 'POST #create' do
    user_sign_in
    context 'with valid attribut' do
      it 'save a new answer in database' do
        expect {post :create, params: {quest_id: quest, answer: attributes_for(:answer)}}.to change(Answer, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: {quest_id: quest.id, answer: attributes_for(:answer)}
        expect(response).to redirect_to quest_path(assigns(:quest))
      end
    end 
     context 'with invalid attribut' do
       it 'not save the quest' do
        expect {post :create, params: {quest_id: quest, answer: attributes_for(:invalid_answer)}}.to_not change(Answer, :count)
      end
      it 're_redirects to show view' do
        post :create, params: {quest_id: quest, answer: attributes_for(:invalid_answer)}
        expect(response).to render_template :new
      end
    end
  end
end

