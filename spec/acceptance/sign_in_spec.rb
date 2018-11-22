require_relative 'acceptance_helper'

feature 'User sign in', %q{
  In order to ask a question
  as a user
  I want to be able to sign in
} do
  given(:user) { create(:user)}

  scenario 'A registered user tries to sign in' do

    sign_in(user)
    
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end
  
  scenario 'A non-registered user tries to sign in' do
   
    visit new_user_session_path

    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '1234567'
    click_on 'Log in'
    
    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end

end
