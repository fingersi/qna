require 'rails_helper'

feature "User can create a answer" do

  given(:user) { create :user }
  given(:question) { create :question}
  
  scenario 'user can create answer on question page' do
    sign_in (user)
    visit question_path(question)
    
    click_on 'Answer'
    fill_in 'Body', with: 'Answer for question for short form'
    click_on 'Send answer'

    expect(page).to have_content 'Answer for question for short form'
  end

  scenario 'user canot create answer with errors' do
    sign_in (user)
    visit question_path(question)
    
    click_on 'Answer'
    click_on 'Send answer'

    expect(page).to have_content 'Answer not saved'
  end

  scenario 'unauthorized user cannot create question' do
    visit question_path(question)
    
    click_on 'Answer'
    fill_in 'Body', with: 'Answer for question for short form'
    click_on 'Send answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end