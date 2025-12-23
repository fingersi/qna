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
end