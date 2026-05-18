require 'rails_helper'

feature "Authorization scenarios" do

  scenario 'user can authenticate' do
    User.create(email: 'test@mail.com', password: 'aabbcc')
    visit new_user_session_path
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: 'aabbcc'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'user can log out' do
    User.create(email: 'test@mail.com', password: 'aabbcc')

    visit new_user_session_path
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: 'aabbcc'
    click_on 'Log in'

    click_on 'log out'

    expect(page).to have_content 'Signed out successfully'
  end

  scenario 'user can sign in' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: 'aabbcc123'
    fill_in 'Password confirmation', with: 'aabbcc123'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'user can sign in with GitHub' do
    mock_github_user(uid: '999', email: 'test@github.com')

    visit root_path

    click_button 'log in'
    click_button 'Sign in with GitHub'

    expect(page).to have_content('Successfully authenticated from Github account.')
    expect(page).not_to have_link('Sign in with github')
  end


  scenario "user cannot sign in with invalid credential" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path

    click_button 'log in'
    click_button 'Sign in with GitHub'

    expect(page).to have_content("Could not authenticate you from GitHub because ")
  end
end