require 'rails_helper'

feature "Author can destroy questions" do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario "Only author can destroy question" do
    sign_in(user)

    create_question
    visit question_path(question)
    click_on 'delete'

    expect(page).to have_content 'Only author can delete this question'
  end

  scenario "unauthorized user cannot create question" do
    visit question_path(question)
    click_on 'delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "Author can destroy question" do
    sign_in(user)
    
    visit question_path(create(:question, author: user))
    click_on 'delete'

    expect(page).to have_content 'Question has been succefully deleted'
  end
end