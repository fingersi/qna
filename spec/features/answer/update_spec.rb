require 'rails_helper'

feature "User can create a answer." do
  given(:user) { create :user }
  given(:question) { create :question }
  
  scenario 'user can edit answer on question page', js: true do
    sign_in (user)
    visit question_path(question)
    
    click_on 'Edit'
    fill_in 'update', with: 'Updated answer body'
    click_on 'Update'

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content answer.body
    within '.answers' do
      expect(page).to have_content 'Updated answer body'
    end

    scenario 'unauthorize user cannot edit answer on question page', js: true do
      sign_in (user)
      visit question_path(question)
      
      click_on 'Edit'
      fill_in 'update', with: 'Updated answer body'
      click_on 'Update'
  
      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to_not have_content 'edit'
      end
    end
  end