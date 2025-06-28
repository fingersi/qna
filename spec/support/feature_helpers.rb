module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def create_question
    visit root_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Question text'
    click_on 'Ask'
  end

  def create_question_with_file
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'New title'
    fill_in 'Body', with: 'New body'
    page.attach_file("question_files", "#{Rails.root}/spec/support/feature_helpers.rb") 
    click_on 'Ask'
  end
end