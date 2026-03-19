require 'rails_helper'

feature "User can update a answer.", js: true  do
  given(:user) { create :user }
  given(:question) { create :question }

  scenario "user gets answer from another user" do
    Capybara.using_session('guest') do
      visit root_path
    end

    Capybara.using_session('user') do
      sign_in(user)
      visit root_path
      click_on 'Ask question'
      fill_in 'Title', with: 'Test title'
      fill_in 'Body', with: 'Question text'
      click_on 'Ask'
    end

    Capybara.using_session('guest') do
      expect(page).to have_content 'Test title'
    end
  end
end