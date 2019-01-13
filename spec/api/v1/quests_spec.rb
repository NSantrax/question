require 'rails_helper'

describe 'Quest API' do
  describe 'GET /index' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/quests', headers: {format: :json}
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/quests', headers: {format: :json, access_token: '1234567'}
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      
      let!(:user) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: user.id )}
      let!(:quests) { create_list(:quest, 2, user: user) }
      let (:quest) { quests.first }
      let!(:answer) { create(:answer, quest: quest, user: user)}

      before { get '/api/v1/quests',  headers: { format: :json, Authorization: "Bearer#{access_token.token}" } }
     
      it 'returns 200 status' do
        expect(response).to be_successfull
      end
      it 'returns list of quests' do
        expect(response.body).to have_json_size(2)
      end
      
      %w(id title body created_at updated_at).each do |attr|
        it "quests object contains #{attr}" do        
          expect(response.body).to be_eql(quest.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in quest object' do
          expect(response.body).to have_json_size(1).at_path("0/answers}")
        end
        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do        
            expect(response.body).to be_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end
  end
end