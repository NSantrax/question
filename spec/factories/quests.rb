FactoryBot.define do
  factory :quest do
    title "MyString"
    body "MyText"
  
  end
  
  factory :invalid_quest, class: "Quest" do
    title nil
    body nil
  end
end
