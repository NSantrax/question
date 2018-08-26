require 'rails_helper' 

feature 'User can create answer', %q{
  The user can create a answer
} do
  given(:user) { create(:user)}
  given(:quest) { create(:quest)}
  scenario 'Authenticated user can create answer' do
 
    sign_in(user)
    
    visit quest_path(quest)
  
    fill_in 'You answer', with: 'My answer'
    click_on 'Create'
    expect(current_path).to eq quest_path(quest)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end
  scenario 'Authenticated user cannot create invalid answer' do
   
   sign_in(user)
    
    visit quest_path(quest)
    click_on 'Create'
    expect(page).to have_content "Ответ не сохранен"
 
  end
  
   scenario 'Non-authenticated user cannot create answer' do
    
    Quest.create!(title:'title', body: 'text 1234567')
   
    visit quests_path
    click_on 'Give an answer'
  
    expect(page).to have_content "You need to sign in or sign up before continuing."
 
   end
end
