require_relative 'acceptance_helper'

feature 'User sign up', %q{
  In order to ask a question
  as a user
  I want to be able to sign up
} do
  #given(:user1) { create(:nonconfirm_user)}
  given(:user) { create(:user)}
  given (:user1) {User.new(email: 'test@example.com', password: '123456789', password_confirmation: '123456789')}
   background do
    # will clear the message queue
    clear_emails
   
    # Will find an email sent to test@example.com
    # and set `current_email`
    open_email(user1.email)
  end
  scenario 'A non-registered user tries to sign up' do
    #user1 = User.new(email: 'test@example.com', password: '123456789', password_confirmation: '123456789')
    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    fill_in 'Password confirmation', with: user1.password
    click_on 'Sign up'
    
    open_email(user1.email)
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
    expect(current_path).to eq '/users/sign_in'

  end
  
  scenario 'A registered user tries to sign up' do
    #user.confirm
    visit new_user_session_path  
    click_on 'Sign up' 
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    
    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq "/users"
  end
  scenario 'A non-confirmed user tries to sign up' do
    
    visit new_user_session_path  
    click_on 'Sign up' 
    fill_in 'Email', with: 'test@test.ru'
    fill_in 'Password', with: '1234567'
    fill_in 'Password confirmation', with: '1234567'
    click_on 'Sign up'
    visit new_user_session_path
    fill_in 'Email', with: 'test@test.ru'
    fill_in 'Password', with: '1234567'
    click_on 'Log in'
    expect(page).to have_content 'You have to confirm your email address before continuing.'
    expect(current_path).to eq "/users/sign_in"
  end

end
