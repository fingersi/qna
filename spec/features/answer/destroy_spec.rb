require 'rails_helper'

feature "Anthor can destroy answers" do
  given(:user) { create :user }
  given(:question) { create :question, :with_answers }

  scenario 'Only author can destroy answer' do
    sign_in(user)

    visit question_answer_path( question, (create :answer, question: question ))

    click_on 'delete'
    expect(page).to have_content 'Only author can delete this answer'
  end

  scenario "unauthorized user cannot create answer" do
    visit question_answer_path(question, create(:answer, question: question))
    click_on 'delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "Author can destroy answer" do
    sign_in(user)
    visit question_answer_path(question, create(:answer, question: question, author: user))
    click_on 'delete'

    expect(page).to have_content 'Answer has been succefully deleted'
  end
end