require 'rails_helper'

RSpec.describe QuestsController, type: :controller do

  let(:quests) {create_list(:quest, 2)}
  
  
  describe 'GET #index' do
    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:quests)).to match_array(quests)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
  
   describe 'GET #show' do
     let(:quest) {create(:quest)}
     before {get :show, params: { id: quest }}
    it 'assigns to requested quest to @quest' do
      expect(assigns(:quest)).to eq quest
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
  
   describe 'GET #new' do
     user_sign_in
     
     before {get :new}
    it 'assigns a new Quest to @quest' do
      expect(assigns(:quest)).to be_a_new(Quest)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
  
  describe 'POST #create' do
    user_sign_in
    
    context 'with valid attribut' do
      it 'save a new quest in database' do
        expect {post :create, params: {quest: attributes_for(:quest)}}.to change(Quest, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: {quest: attributes_for(:quest)}
        expect(response).to redirect_to quest_path(assigns(:quest))
      end
    end 
     context 'with invalid attribut' do
       it 'not save the quest' do
        expect {post :create, params: {quest: attributes_for(:invalid_quest)}}.to_not change(Quest, :count)
      end
      it 're_redirects to show view' do
        post :create, params: {quest: attributes_for(:invalid_quest)}
        expect(response).to render_template :new
      end
    end
  end
end
