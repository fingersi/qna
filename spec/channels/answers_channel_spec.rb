require "rails_helper"

RSpec.describe AnswersChannel, type: :channel do
  it "Successfully connected to answer channel" do
    subscribe(question_id: 1)
    
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("answers_question_1")
  end
end