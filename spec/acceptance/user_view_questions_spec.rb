require 'rails_helper'

feature 'User can view list questions', %q{
  the user can view list questions
} do
  given(:quest) { create(:quest)}
  given(:quest1) { create(:quest)}
  scenario 'User can view list questions' do
 
    visit quests_path
    Quest.all.each do |quest|
      expect(page).to have_content quest.title
      expect(page).to have_content quest.body
    end
  end
  
end
