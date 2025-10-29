require 'rails_helper'

feature "Anthor can set one answer as best for question" do
  given(:user) { create :user }
  given(:question) { create :question, :with_answers, author: user }
  let!(:answer) { create :answer, question: question }


  scenario 'Only question author can set best answer', js: true do
    sign_in(user)
    
    visit question_path( create :question, :with_answers )

    expect(page).to_not have_content 'Set Best'
  end

  scenario 'Author can set answer as best', js: true do
    sign_in (user)
    visit question_path(question)

    page.find(:id, answer.id.to_s ).click

    expect(page).to have_content 'Best answer'
    expect(all( :id, "best-#{answer.id}").count).to eq(1)
  end

  scenario 'Best answer listed always in the first place', js: true do
    sign_in (user)
    visit question_path(question)

    page.find(:id, answer.id.to_s ).click


    within('.answers') do
      expect(page.all('tr', text: 'Set Best')[0]).to have_content 'Best answer'
    end
  end

  scenario 'Only one answer could be set as best answer', js: true do
    sign_in (user)
    visit question_path(question)

    expect(all('.best').count).to eq(0)

    within('.answers') do
      page.all(:link, text: 'Set Best').each do |el|
        el.click
        expect(all('td', text: 'Best answer').count).to eq(1)
      end
    end

    expect(all('.best').count).to eq(1)
    expect(page).to have_content 'Best answer'
  end
end
