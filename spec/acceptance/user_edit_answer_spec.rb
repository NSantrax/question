require_relative 'acceptance_helper' 

feature 'User can edit answer', %q{
  The author can edit the answer
  to correct the error
} do
  given(:user) { create(:user)}
  given!(:quest) { create(:quest)}
  given!(:answer) { create(:answer, quest: quest)}
  
  scenario 'Unauthenticated user cannot edit answer' do
    visit quest_path(quest)
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
    
      expect(current_path).to eq quest_path(quest)
      within '.answers' do
        expect(page).to have_content 'My new answer'
      end
    end
  
    scenario 'Author cannot update invalid his answer', js: true do
   
      click_on 'Edite'
   
      expect(page).to have_content "Body is too short"
   
    end
  
    scenario 'Authenticated user cannot edit other answer'
 end
end
