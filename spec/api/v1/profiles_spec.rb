require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    let(:api_path){"/api/v1/profiles/me.json"}
    it_behaves_like 'API Autenticable'

    context 'authorized', js: true do
      #before { access_token.resource_owner_id = me.id }
      let!(:me) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: me.id )}
      
      before { get "/api/v1/profiles/me.json?access_token=#{access_token.token}"}
     
      it_behaves_like 'API Response Success'
      %w(id email).each do |attr|
        it "contains #{attr}" do
          #p response.body
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