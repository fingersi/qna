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

  def create_question_with_file(user, filename = 'feature_helpers.rb')
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'New title'
    fill_in 'Body', with: 'New body'
    page.attach_file('question_files', "#{Rails.root}/spec/support/#{filename}") 
    click_on 'Ask'
  end

  def create_question_with_reward(title, reward_name, image)
    visit root_path
    click_on 'Ask question'
    fill_in 'Title', with: title
    fill_in 'Body', with: "Question text #{title}"
    fill_in 'Reward name', with: reward_name
    attach_file 'Image', "#{Rails.root}/spec/fixtures/files/#{image}"
    click_on 'Ask'
  end

  def answer_question(question, body)
    visit question_path(question)
    click_on 'Answer'
    fill_in 'answer_body', with: body
    click_on 'Send answer'
  end

  def log_out
    visit root_path
    click_on 'log out'
  end
end
