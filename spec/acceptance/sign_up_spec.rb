require_relative 'acceptance_helper'

feature 'User sign up', %q{
  In order to ask a question
  as a user
  I want to be able to sign up
} do
  given(:user) { create(:user)}
  scenario 'A non-registered user tries to sign up' do
   visit new_user_session_path
   click_on 'Sign up'
   fill_in 'Email', with: "usertest@test.com"
   fill_in 'Password', with: '123456789'
   fill_in 'Password confirmation', with: '123456789'
   click_on 'Sign up' 
    
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end
  
  scenario 'A registered user tries to sign up' do
    visit new_user_session_path  
    click_on 'Sign up' 
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    
    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq "/users"
  end

end
