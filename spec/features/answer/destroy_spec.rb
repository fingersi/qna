require 'rails_helper'

feature "Anthor can destroy answers" do
  given(:user) { create :user }
  given(:question) { create :question, :with_answers }

  scenario 'Only author can destroy answer' do
    sign_in(user)
    visit answer_path( create :answer, question: question, author: user )
    click_on 'delete'

    expect(page).to have_content 'Answer has been succefully deleted'
  end

  scenario "unauthorized user cannot create answer" do
    visit answer_path(create(:answer, question: question))

    expect(page).to have_no_content 'delete'
  end

  scenario "Author can destroy answer" do
    sign_in(user)
    visit answer_path(create(:answer, question: question, author: user))
    click_on 'delete'

    expect(page).to have_content 'Answer has been succefully deleted'
  end
end