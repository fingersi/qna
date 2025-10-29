require 'rails_helper'

feature "User can create questions with reward" do
  given(:user) { create :user }

  scenario "user can create with link" do
    sign_in(user)
    create_question_with_reward('Gold Question', 'Gold reward', 'gold.png')
    question = Question.where(title: 'Gold Question').first
    answer_question(question, 'Gold answer')
    visit question_path(question)
    click_on 'Set Best'

    create_question_with_reward('Silver Question', 'Silver reward', 'silver.png')
    question = Question.where(title: 'Silver Question').first
    answer_question(question, 'Silver answer')
    visit question_path(question)

    visit profile_path

    expect(page).to have_content 'Gold Question'
    expect(page).to have_css("img[src*='gold.png']")
    expect(page).not_to have_content 'Silver Question'
  end
end
