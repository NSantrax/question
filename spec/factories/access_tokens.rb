ActiveRecord::Base.inspect

FactoryBot.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    application { create(:oauth_application) }
    #resource_owner_id { create(:user).user_id }
    #scopes :user
  end
end