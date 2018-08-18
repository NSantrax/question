require 'rails_helper' 

feature 'User can create answer', %q{
  the user can create a answer
} do
  scenario 'Uer can create answer' do
 
    User.create!(email:'user@test.com', password: '1234567')
    visit new_user_session_path

    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '1234567'
    click_on 'Log in'
    
    Quest.create!(title:'title', body: 'text 1234567')
    visit quests_path
    
    click_on 'Give an answer'
  
    fill_in 'Body', with: 'Test text'
      
    click_on 'Create'
    expect(page).to have_content 'Ответ сохранен'
 
  end
  scenario 'User cannot create invalid answer' do
   
    User.create!(email:'user@test.com', password: '1234567')
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '1234567'
    click_on 'Log in'
    
    Quest.create!(title:'title', body: 'text 1234567')
    visit quests_path
    
    click_on 'Give an answer'
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
 
  end
  
   scenario 'Non-authenticated user cannot create answer' do
    
    Quest.create!(title:'title', body: 'text 1234567')
   
    visit quests_path
    click_on 'Give an answer'
  
    expect(page).to have_content "You need to sign in or sign up before continuing."
 
   end
end
