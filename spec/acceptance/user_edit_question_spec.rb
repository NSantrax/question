require_relative 'acceptance_helper'

feature 'User can edit question', %q{
  The author can edit the question
  to correct the error
} do
  given(:user) { create(:user)}
  given!(:quest) { create(:quest, user: user)}
 scenario 'Unauthenticated user cannot edit question', js: true do
    visit quests_path
    expect(page).to_not have_link "Edit"
  end 
  
  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit quest_path(quest)
    end
    scenario 'Author can see link Edit', js: true do
      expect(page).to have_link "Edit"
    end
  
    scenario 'Author can edite question', js: true do
    
      click_on 'Edit'
      fill_in 'Title', with: 'My new question'
      fill_in 'Body', with: 'My new text'
      click_on 'Save'
      within '.quest' do
        expect(page).to_not have_content quest.body
        #expect(page).to_not have_selector 'textarea'
        expect(page).to have_content 'My new question'
        expect(page).to have_content 'My new text'
      end    
    end
  
    scenario 'Author cannot update invalid his question', js: true do
   
      click_on 'Edit'
      fill_in 'Body', with: '1'
      click_on 'Save'
      expect(current_path).to eq quest_path(quest)
    end
  end
  
  describe 'Authenticated user' do
    before do
      @user = User.create(email: 'other@mail.ru', password: '1234567', password_confirmation: '12345678')
      sign_in(@user)
      visit quest_path(quest)
    end
    scenario 'cannot edit other question', js: true do
      expect(page).to_not have_link "Edit"
    end
  end
end
