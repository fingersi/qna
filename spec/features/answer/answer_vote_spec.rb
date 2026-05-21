require 'rails_helper'

feature "User can vote for question.", js: true do

  given(:user) { create :user }
  given(:user2) { create :user }
  given(:question) { create :question }
  let!(:answer) { create :answer, question: question }
  
  scenario 'user can vote for answer on question page' do
    sign_in(user)
    visit question_path(question)

    page.find('[data-vote-type="like"]', wait: 5).click

    expect(page).to have_content 'You successfully voted'
    
    expect(
      page.find('[data-answer-view="true"]')
    ).to have_text('1')

    page.find('[data-vote-type="dislike"]', wait: 5).click

    expect(
      page.find('[data-answer-view="true"]')
    ).to have_text('-1')
  end

  scenario 'answer author cannot vote for his answer' do
    question_user_author = create :question
    answer = create :answer, question: question_user_author, author: user
    sign_in(user)
    visit question_path(question_user_author)

    expect(page).to have_no_content 'Like'
    
    expect(
      page.find('[data-answer-view="true"]')
    ).to have_text('0')
  end
end

