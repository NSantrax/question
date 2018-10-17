require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) {create (:user)}
  let!(:quest) {create(:quest, user: user)}

  describe 'POST #create' do
    user_sign_in
    context 'with valid attribut' do
      it 'save a new answer in database' do
        expect {post :create, params: {quest_id: quest, answer: attributes_for(:answer)}, format: :json}.to change(Answer, :count).by(1)
      end
      
      it 'render create template' do
        post :create, params: {quest_id: quest.id, answer: attributes_for(:answer, user: user)}, format: :json
        expect(response).to render_template @answer
      end
    end
     
    context 'with invalid attribut' do
      it 'not save the quest' do
        expect {post :create, params: {quest_id: quest, answer: attributes_for(:invalid_answer, user: user)}, format: :json}.to_not change(Answer, :count)
      end
      
      it 'render create template' do
        post :create, params: {quest_id: quest, answer: attributes_for(:invalid_answer, user: user)}, format: :json

        expect(response).to render_template @answer
      end
    end
  end
    
  describe 'PATCH #update' do
    let(:answer){create(:answer, quest: quest, user: user)}
    user_sign_in
    it 'assigns the requested answer to @answer' do
        patch :update, params:{id: answer, quest_id: quest, answer: attributes_for(:answer, user: user)}, format: :json
        expect(assigns(:answer)).to eq answer
    end
    
    it 'assigns the requested quest to @quest' do
        patch :update, params:{id: answer, quest_id: quest, answer: attributes_for(:answer, user: user)}, format: :json
        expect(assigns(:quest)).to eq quest
    end
      
    it 'changes answer attributes' do
        patch :update, params:{ id: answer, quest_id: quest, user: user, answer: {body: 'new body'}}, format: :json
        answer.reload
        expect(answer.body).to eq 'new body'
    end
      
    it 'render update template' do
        patch :update, params:{ id: answer, quest_id: quest, answer: attributes_for(:answer, user: user)}, format: :json
        expect(response).to render_template @answer
    
    end
  end
end

