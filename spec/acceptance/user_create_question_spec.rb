require_relative 'acceptance_helper'

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
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb" 
    click_on 'Create'
    expect(current_path).to eq quests_path
    visit quest_path(quest)
    
    expect(page).to have_content 'Test text'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
   
  end
  
  scenario 'User cannot create invalid qestion' do
   sign_in(user)
     
   visit quests_path
    click_on 'Ask question'
    click_on 'Create'
    
    expect(page).to have_content "Body is too short"
    expect(current_path).to eq quests_path
  end
  
  scenario 'Non-authenticated user cannot create question' do
    visit quests_path

    expect(page).to_not have_content 'Ask question'
  end
end
