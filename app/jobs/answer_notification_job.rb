class AnswerNotificationJob < ApplicationJob

  def perform(answer)    
    question = answer.question
    question.subscribers.find_each do |subscriber|
      AnswerMailer.notification(subscriber, answer).deliver_later
    end
  end
end
