require 'rails_helper'

feature "Author can destroy questions" do

  given(:user) { create :user }
  given(:question) { create :question, :with_file }

  scenario "Only author can destroy question" do
    sign_in(user)
    create_question
    visit question_path(question)
    click_on 'log out'

    expect(page).to have_no_content 'delete'
  end

  scenario "unauthorized user cannot create question" do
    visit question_path(question)
    
    expect(page).to have_no_content 'delete'
  end

  scenario "Author can destroy question" do
    sign_in(user)
    visit question_path(create(:question, author: user))
    click_on 'delete'

    expect(page).to have_content 'Question has been succefully deleted'
  end

  scenario "Author can delete file attached to question" do
    create_question_with_file(user, 'feature_helpers.rb')
    click_on 'delete file'

    expect(page).to have_no_content 'feature_helpers.rb'
  end

  scenario "unauthorized user cannot delete file attached to question" do
    create_question_with_file(user)
    visit root_path
    click_on 'log out'

    expect(page).to have_no_content 'delete file'
  end
end