require 'sphinx_helper'

feature 'Search', sphinx: true do
  given!(:user) { create(:user, email: 'searchable_user@example.com') }
  given!(:question) { create(:question, title: 'One five', author: user) }
  given!(:answer) { create(:answer, body: 'One two', question: question, author: user) }
  given!(:comment) { create(:comment, body: 'One three', commentable: question, user: user) }
  given!(:question_other) { create(:question, title: 'four three', author: user) }
  given!(:answer_other) { create(:answer, body: 'five', question: question_other, author: user) }

  before do
    ThinkingSphinx::Test.index
    sleep 1
  end

  scenario 'Search in all categories' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: 'One'
    click_on 'Search'

    expect(page).to have_content(question.title)
    expect(page).to have_content(answer.body)
    expect(page).to have_content(comment.body)
  end

  scenario 'Search by Questions' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: 'One'
    click_on 'Search'
    click_on 'Questions'
    
    expect(page).to have_content(question.title)
    expect(page).not_to have_content(answer.body)
    expect(page).not_to have_content(comment.body)
  end

  scenario 'Search by Answers' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: 'five'
    click_on 'Search'
    click_on 'Answers'
      
    expect(page).to have_content(answer_other.body)
    expect(page).not_to have_content(question.title)
  end

  scenario 'Search for Comments' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: 'three'
    click_on 'Search'
    click_on 'Comments'

    expect(page).to have_content(comment.body)
    expect(page).not_to have_content(question_other.title)
  end

  scenario 'Empty request' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: ''
    click_on 'Search'

    expect(page).to have_content('Cannot find anything')
  end

  scenario 'Nothing to find' do
    sign_in(user)
    visit root_path

    fill_in 'q', with: 'My uncle, of most honest principles,'
    click_on 'Search'

    expect(page).to have_content('Cannot find anything')
  end
end