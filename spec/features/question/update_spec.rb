require 'rails_helper'

feature "User can create questions" do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario "user can create question" do
    sign_in(user)
    visit edit_question_path(question)
    attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]
    click_on 'Ask'

    expect(page).to have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'
  end
end