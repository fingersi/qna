require 'rails_helper'

feature "User can create questions" do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario "user can create question" do
    sign_in(user)
    create_question

    expect(page).to have_content 'Your question have successfuly saved!'
    expect(page).to have_content 'Test title'
    expect(page).to have_content 'Question text'
  end

  scenario 'user cannot create question with errors' do
    sign_in(user)
    click_on 'Ask question'
    click_on 'Ask'
    
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end


  scenario 'unauthorized user cannot create question' do
    visit root_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'password'
  end
end
