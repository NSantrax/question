require_relative 'acceptance_helper' 

feature 'User can add file to answer', %q{
  In order illustrate my answer
  Answer's author can to attach files
} do
  given(:user) { create(:user)}
  given!(:quest) { create(:quest, user: user)}
  
  background do
    sign_in(user)
    visit quest_path(quest)
  end

  scenario 'Authenticated user adds files to answer', js: true do
    
    fill_in 'You answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
