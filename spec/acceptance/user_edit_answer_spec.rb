require_relative 'acceptance_helper' 

feature 'User can edit answer', %q{
  The author can edit the answer
  to correct the error
} do
  given(:user) { create(:user)}
  given!(:quest) { create(:quest, user: user)}
  given!(:answer) { create(:answer, quest: quest, user: user)}
  
  scenario 'Unauthenticated user cannot edit answer', js: true do
    visit quests_path
    expect(page).to_not have_link "Edit"
  end 
  
  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit quest_path(quest)
    end
    scenario 'Author can see link Edit', js: true do
    
      within '.answers' do
        expect(page).to have_link "Edit"  
      end
    end
  
    scenario 'Author can edite answer', js: true do
    
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'My new answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'My new answer'
        expect(page).to_not have_selector 'textarea'
      end
    
    end
  
    scenario 'Author cannot update invalid his answer', js: true do
   
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: '1'
      end
      click_on 'Save'
      expect(page).to have_content "Body is too short"
   
    end
  end
  
  describe 'Authenticated user' do
    before do
      @user = User.create(email: 'other@mail.ru', password: '1234567', password_confirmation: '12345678')
      sign_in(@user)
      visit quest_path(quest)
    end
    scenario 'cannot edit other answer', js: true do
      within '.answers' do
       expect(page).to_not have_link "Edit"
      end  
    end
  end
end
