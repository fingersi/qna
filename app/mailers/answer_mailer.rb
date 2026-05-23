class AnswerMailer < ApplicationMailer
  def notification(user, answer)
    @user = user
    @answer = answer
    @question = answer.question

    mail(to: @user.email, subject: "Новый ответ на вопрос: #{@question.title}")
  end
end
