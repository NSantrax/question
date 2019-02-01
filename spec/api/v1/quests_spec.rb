require 'rails_helper'

describe 'Quest API' do
  describe 'GET /index' do
    let(:api_path){"/api/v1/quests.json"}
    it_behaves_like 'API Autenticable'

    context 'authorized', js: true do
      
      let!(:user) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id )}
      let!(:quests) { create_list(:quest, 2, user: user) }
      let (:quest) { quests.first }
      let!(:answer) { create(:answer, quest: quest, user: user)}
      let!(:comment) { create(:comment, commentable: quest, user: user)}

      before { get "/api/v1/quests.json?access_token=#{access_token.token}"}
      it_behaves_like 'API Response Success'

      it 'returns list of quests' do
        expect(response.body).to have_json_size(2)
      end
      
      %w(id title body).each do |attr|
        it "quests object contains #{attr}" do        
          expect(response.body).to match(attr)
        end
      end
    end
  end
  describe 'GET /show' do
    context 'unauthorized', js: true do
      let(:api_path){"/api/v1/quests/1.json"}
      it_behaves_like 'API Autenticable'
    end

    context 'authorized', js: true do
      
      let!(:user) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id )}
      let!(:quests) { create_list(:quest, 2, user: user) }
      let (:quest) { quests.first }
      let!(:answer) { create(:answer, quest: quest, user: user)}
      let!(:comment) { create(:comment, commentable: quest, user: user)}

      before { get "/api/v1/quests/1.json?access_token=#{access_token.token}"  }
      it_behaves_like 'API Response Success'
      
      %w(id title body created_at updated_at).each do |attr|
        it "quests object contains #{attr}" do        
          expect(response.body).to match(attr)
        end
      end
      it "quests object contains short_title" do        
          expect(response.body).to match(quest.title.truncate(10))
      end

      context 'answers' do
        let(:objects) { 'answers' }
        let(:object) { answer }
        it_behaves_like 'API Objectable'
      end
      context 'comments' do
        let(:objects) { 'comments' }
        let(:object) { comment }
        it_behaves_like 'API Objectable'
      end
    end
  end
  describe 'POST /create', js: true do
    context 'unauthorized' do
      let(:api_path){"/api/v1/quests.json"}
      it_behaves_like 'API Autenticable Post'
    end

    context 'authorized' do
      
      let!(:user) { create(:user, admin: true) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
      let(:api_path){"/api/v1/quests.json?access_token=#{access_token.token}"}
      context 'with valid attribut', js: true do    
        it 'returns 200 status' do
          post api_path, params: { quest: { title: 'test@mail.ru', body: 'abc123'} } 
          expect(response).to be_successful
        end
        it 'save a new quest in database' do
          expect{post api_path, params: { quest: { title: 'test@mail.ru', body: 'abc123'} } }.to change(Quest, :count).by(1)
        end  
      end 
      context 'with invalid attribut',js:true do
        it 'not save the quest' do
          expect {post api_path, params: { quest: { title: nil, body: 'abc123'} } }.to_not change(Quest, :count)
        end
      end
    end
  end
end