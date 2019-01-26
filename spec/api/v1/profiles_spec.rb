require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me.json'
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/profiles/me.json?access_token='1234567"
        expect(response.status).to eq 401
      end
    end

    context 'authorized', js: true do
      #before { access_token.resource_owner_id = me.id }
      let!(:me) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: me.id )}
      
      before { get "/api/v1/profiles/me.json?access_token=#{access_token.token}"}
     
      it 'returns 200 status' do
        expect(response).to be_success
      end
      %w(id email).each do |attr|
        it "contains #{attr}" do
          p response.body
          # expect(response.body).to be_eql(me.send(attr.to_sym).to_json).at_path('attr')
          expect(response.body).to match(attr)

        end
      end
      
      %w(password encrypted_password).each do |attr|
        it "does not contains #{attr}" do
          expect(response.body).to_not match(attr)
        end
      end
    end
  end
end