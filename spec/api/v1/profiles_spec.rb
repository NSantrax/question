require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', headers: {format: :json}
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', headers: {format: :json, access_token: '1234567'}
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      #before { access_token.resource_owner_id = me.id }
      let!(:me) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: me.id )}
      
      before { get '/api/v1/profiles/me',  headers: { format: :json, Authorization: "Bearer#{access_token.token}" } }
     
      it 'returns 200 status' do
        p me
        p access_token
        p response.status
        p response
        expect(response).to be_successfull
      end
      %w(id email).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_eql(me.send(attr.to_sym).to_json).at_path('attr')
        end
      end
      
      %w(password encrypted_password).each do |attr|
        it "does not contains #{attr}" do
          expect(response.body).to_not have_json_path('attr')
        end
      end
    end
  end
end