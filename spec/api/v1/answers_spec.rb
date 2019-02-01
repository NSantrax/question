require 'rails_helper'

describe 'Answer API', js: true do
  let!(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id )}
  let! (:quest) { create(:quest, user: user) }
  let!(:answers) { create_list(:answer, 2, quest: quest, user: user)}
  let!(:answer) {answers.first}
  let!(:comment) { create(:comment, commentable: answer, user: user)}  
  describe 'GET /index' do
    context 'unauthorized' do
      let(:api_path){"/api/v1/quests/1/answers.json"}
      it_behaves_like 'API Autenticable'
    end

    context 'authorized' do
      before { get "/api/v1/quests/1/answers.json?access_token=#{access_token.token}" }
     
      it_behaves_like 'API Response Success'

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2)
      end
      
      %w(id body).each do |attr|
        it "answers object contains #{attr}" do        
          expect(response.body).to match(attr)
        end
      end
    end
  end
  describe 'GET /show' do
    context 'unauthorized' do
      let(:api_path){"/api/v1/answers/1.json"}
      it_behaves_like 'API Autenticable'
    end

    context 'authorized' do

      before { get "/api/v1/answers/1.json?access_token=#{access_token.token}" }
     
      it_behaves_like 'API Response Success'
      
      %w(id body created_at updated_at).each do |attr|
        it "answers object contains #{attr}" do        
          expect(response.body).to match(attr)
        end
      end
      it "answers object contains quest_title" do        
          expect(response.body).to match(answer.quest.title.to_json)
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
      let(:api_path){"/api/v1/quests/1/answers.json"}
      it_behaves_like 'API Autenticable Post'
    end

    context 'authorized' do
      
      let!(:user) { create(:user, admin: true) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
      let!(:quest) { create(:quest, user: user) }
      let(:api_path){"/api/v1/quests/1/answers.json?access_token=#{access_token.token}"}
      context 'with valid attribut' do
        it 'returns 200 status' do
          post api_path, params: { answer: { body: 'abc123'} } 
          expect(response).to be_successful
        end
        it 'save a new answer in database' do
          expect {post api_path, params: {answer: { body: '12345'}}}.to change(Answer, :count).by(1)
        end
    
      end 
      context 'with invalid attribut' do
        it 'not save the answer' do
          expect {post api_path, params:{answer: { body: nil}}}.to_not change(Answer, :count)
        end
      end
    end
  end
end