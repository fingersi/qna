require 'rails_helper'

feature "User get question/questions" do

  given(:user) { create :user }
  given(:question) { create :question}

  scenario 'user can get list of all questions' do
    sign_in(user)
    create_question
    visit root_path

    expect(page).to have_content 'Test title'
    expect(page).to have_content  'Question text'
  end

  scenario 'user can get question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

end