require 'rails_helper'

feature "User can vote for question.", js: true do

  given(:user) { create :user }
  given(:question) { create :question }
  let!(:answer) { create :answer, question: question }
  
  scenario 'user can vote for answer on question page' do
    sign_in(user)
    visit question_path(question)

    page.find('[data-vote-type="like"]', wait: 5).click
    visit question_path(question)
    expect(
      page.find('[data-answer-view="true"]')
    ).to have_text('1')
  end
end

