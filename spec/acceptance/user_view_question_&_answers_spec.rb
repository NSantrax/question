require_relative 'acceptance_helper'

feature 'User can view  question with answers', %q{
  the user can view question with answers
} do
  given(:user) {create(:user)}
  given(:quest) { create(:quest, user: user)}
 
  scenario 'User can view question' do
   Answer.create!(quest:quest, body: 'text 1234567', user: user)
   Answer.create!(quest:quest, body: 'text text', user: user)
    visit quests_path
    
    expect(page).to have_content "MyString"
    expect(page).to have_content "MyText"
    quest.answers.each do |answer|
      expect(page).to have_content answer.body
      expect(current_path).to eq quests_path
    end
  end
end
