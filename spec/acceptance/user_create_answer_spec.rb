require_relative 'acceptance_helper' 

feature 'User can create answer', %q{
  The user can create a answer
} do
  given(:user) { create(:user)}
  given!(:quest) { create(:quest, user: user)}

  scenario 'Authenticated user can create answer', js: true do
    
    user.confirm
    sign_in(user)
    visit quest_path(quest)
  
    fill_in 'You answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    #expect(current_path).to eq quest_path(quest)
    
    visit quest_path(quest)
    within '.answers' do
      expect(page).to have_content 'My answer'
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
  
  scenario 'Authenticated user can not create invalid answer', js: true do
    user.confirm
    sign_in(user)
    visit quest_path(quest)
    click_on 'Create'

    expect(page).to have_content "Body is too short"
   
  end
  
   scenario 'Non-authenticated user cannot create answer' do
     visit quest_path(quest)
     expect(page).to_not have_content "Create"
   end
end
