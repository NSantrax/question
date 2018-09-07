require_relative 'acceptance_helper'

feature 'User can view  question with answers', %q{
  the user can view question with answers
} do
  given(:quest) { create(:quest)}
 
  scenario 'User can view question' do
   Answer.create!(quest:quest, body: 'text 1234567')
   Answer.create!(quest:quest, body: 'text text')
    visit quests_path
    click_on 'Показать вопрос'
    expect(page).to have_content "MyString"
    expect(page).to have_content "MyText"
    quest.answers.each do |answer|
      expect(page).to have_content answer.body
      expect(page).to have_content 'Question'
    end
  end
end
