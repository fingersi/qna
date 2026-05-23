require 'rails_helper'

  
RSpec.describe AnswerNotificationJob, type: :job do
  let(:author) { create(:user) }
  let(:subscriber) { create(:user) }
  let(:question) { create(:question, author: author) }
  let(:answer) { create(:answer, question: question) }

  before do
    question.subscribers << subscriber
  end

  it 'notify all subscribers' do
    expect {
      AnswerNotificationJob.perform_now(answer)
    }.to have_enqueued_mail(AnswerMailer, :notification).with(author, answer)
     .and have_enqueued_mail(AnswerMailer, :notification).with(subscriber, answer)
  end

  
end
