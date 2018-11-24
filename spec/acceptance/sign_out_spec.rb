require_relative 'acceptance_helper'

feature 'User sign out', %q{
  As a log in user
  I want to be able to log out
} do
  given(:user) { create(:user)}
  scenario 'A logged in user tries to log out' do
   user.confirm
   sign_in(user)
   click_on 'Выйти' 
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
  scenario 'A non-logged in user tries to log out' do
  
   visit root_path
   expect(page).not_to have_content('Выйти')
    
  end

end
