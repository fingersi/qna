require 'rails_helper'

feature "User can create questions" do
  given(:user) { create :user }
  given(:question) { create :question }
  given(:question_subscription) { create :question }


  scenario "user can subscribe for question" do
    sign_in(user)
    visit question_path(question)

    click_on 'Subscribe'

    expect(page).to have_content "You successfully subscripted to #{question.title}"
  end

  scenario "Author subscripted for question" do
    sign_in(user)

    expect {
      Question.create!(title: "My Title", body: "My Body", author: user)
    }.to change(Subscription, :count).by(1) 
  end

  scenario 'user can unsubscribe for question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Subscribe'
    visit question_path(question)
    click_on 'Unsubscribe'

    expect(page).to have_content "Your subscription to #{question.title} removed"
  end

end