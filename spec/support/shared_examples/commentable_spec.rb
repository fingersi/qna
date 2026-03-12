RSpec.shared_examples 'commentable' do
  scenario 'User add comment on the resource', js: true do
    sign_in(user)
    visit path_to_item

    within '.comment_form' do
      fill_in 'comment[body]', with: 'My awesome comment'
      click_on 'Add comment'
    end

    expect(page).to have_content 'My awesome comment'
  end
  
  scenario 'users get comment from another user with ws', js: true do
    Capybara.using_session('guest') do
      visit path_to_item
    end

    Capybara.using_session('user') do
      sign_in(user)
      visit path_to_item
      fill_in 'comment[body]', with: 'WS Comment'
      click_on 'Add comment'
    end

    Capybara.using_session('guest') do
      expect(page).to have_content 'WS Comment'
    end
  end
end