FactoryBot.define do
  sequence :email do |n|
   "user#{n}@test.com"
  end  
  
  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
    confirmed_at '02.03.2018'
    confirmation_sent_at '03.03.2018'
  end

  factory :nonconfirm_user, class: "User" do
    email
    password '12345678'
    password_confirmation '12345678'
    
  end

end
