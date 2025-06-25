require 'rails_helper'

feature "Author can destroy questions" do

  given(:user) { create :user }
  given(:question) { create :question, :with_file }

  scenario "Only author can destroy question" do
    sign_in(user)

    create_question
    visit question_path(question)
    click_on 'delete'

    expect(page).to have_content 'Only author can delete this question'
  end

  scenario "unauthorized user cannot create question" do
    visit question_path(question)
    click_on 'delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "Author can destroy question" do
    sign_in(user)
    
    visit question_path(create(:question, author: user))
    click_on 'delete'

    expect(page).to have_content 'Question has been succefully deleted'
  end

  scenario "Author can delete one photo attached to question" do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'New title'
    fill_in 'Body', with: 'New body'
    page.attach_file("question_files", "#{Rails.root}/spec/support/feature_helpers.rb") 
    click_on 'Ask'

    click_on 'delete file'

    expect(page).to have_no_content 'feature_helpers'
  end

  scenario "unauthorized user cannot delete file attached to question" do
    visit new_question_path
    create_question_with_file

    expect(page).to have_no_content 'delete file'
  end
end