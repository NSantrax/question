require 'rails_helper'


RSpec.describe User, :type => :model do
  describe 'validations' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
  end
  describe '.find_for_oauth' do
    let!(:user) {create (:user)}
    let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    context 'user already has authorization' do
      it 'returns user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end
        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end
        it 'creates authorization with provider & uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: "new@user.com" }) }
        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
        it 'fills user email' do
          expect(User.find_for_oauth(auth).email).to eq auth.info[:email]
        end
        it 'creates authorization for user' do
          expect(User.find_for_oauth(auth).authorizations).to_not be_empty
        end
        it 'creates authorization with provider & uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
        
      end
    end
  end
  describe '.send_daily_daigest' do
    let(:users) {create_list(:user, 2)}
    let(:user) { users.first } 
    it 'should send daily daigest to all users' do
      users.each { |user| expect(DailyMailer).to receive(:digest).with(user).and_call_original}
      DailyDigestWorker.perform_async
    end
    xit 'should send daily daigest all questions created in the last 24 hours' do
      
      #User.daily_mailer_digest
    end
  end
end
