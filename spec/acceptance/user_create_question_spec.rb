require 'rails_helper'

feature 'User can create question', %q{
  the user can create a question
  to get an answer from the community
} do
  given(:user) { create(:user)}
  scenario 'User can create qestion' do
   sign_in(user)
    
    visit quests_path

    click_on 'Ask question'
  
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Test text'
      
    click_on 'Create'
    expect(page).to have_content 'Question'
 
  end
  scenario 'User cannot create invalid qestion' do
   sign_in(user)
     
   visit quests_path
 
    click_on 'Ask question'
    
    click_on 'Create'
    
     expect(page).to have_content "Title can't be blank"
     expect(current_path).to eq quests_path
  end
  
  scenario 'Non-authenticated user cannot create question' do
    visit quests_path
    click_on 'Ask question'
    expect(page).to have_content "You need to sign in or sign up before continuing."
 
   end
end
