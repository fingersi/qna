require 'rails_helper'

feature "User can update a answer.", js: true  do
  given(:user) { create :user }
  given(:question) { create :question, :with_answers, author: user }

  scenario "user gets answer from another user" do
    Capybara.using_session('guest') do
      visit question_path(question)
    end

    Capybara.using_session('user') do
      sign_in(user)
      visit question_path(question)
      click_on 'Answer'
      fill_in 'answer_body', with: 'WS Answer'
      click_on 'Send answer'
    end

    Capybara.using_session('guest') do
      expect(page).to have_content 'WS Answer'
    end
  end
end