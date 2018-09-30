require_relative 'acceptance_helper' 

feature 'User can add file to question', %q{
  In order illustrate my question
  Question's author can to attach files
} do
  given(:user) { create(:user)}
  background do
    sign_in(user)
    visit new_quest_path
  end

  scenario 'Authenticated user adds files when ask question', js: true do
    
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Test text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    
    expect(page).to have_content 'spec_helper.rb'
  end
end
