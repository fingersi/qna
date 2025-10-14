require 'rails_helper'

feature "User can create questions" do

  given(:user) { create :user }
  given(:question) { create :question }
  given(:url) { 'https://gist.github.com/fingersi/8ecbec348a470a6076d7d8760ba4cf83' }
  
  scenario "user can create with link" do 
    sign_in(user)

    visit root_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Question text'
    fill_in 'Link name', with: 'Best url'
    fill_in 'Url', with: url
    click_on 'Ask'

    expect(page).to have_link 'Best url', href: url

  end

  scenario "user can update question and add link" do 
    sign_in(user)

    visit question_path(question)
    click_on 'Edit'
    fill_in 'Link name', with: 'Edit link url'
    fill_in 'Url', with: url
    click_on 'Ask'

    expect(page).to have_link 'Edit link url', href: url
  end

end