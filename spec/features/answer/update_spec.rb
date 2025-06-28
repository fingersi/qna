require 'rails_helper'

feature "User can update a answer." do
  given(:user) { create :user }
  given(:question) { create :question, author: user }
  let!(:answer) { create :answer, question: question }
  
  scenario 'user can update answer on question page', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Edit'
    fill_in 'answer[body]', with: ' New answer body '
    click_on 'Save'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'New answer body'
  end

  scenario 'unauthorize user cannot edit answer on question page', js: true do
    visit question_path(question)
    
    expect(page).to_not have_content 'Edit'
  end
end