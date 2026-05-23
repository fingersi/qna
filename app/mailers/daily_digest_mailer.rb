class DailyDigestMailer < ApplicationMailer

  def digest(user, questions)
     @hi ='hi'
     @user = user
     @questions = user.subscribed_questions.where('created_at >= ?', 24.hours.ago)
     mail to: user.email, subject: 'new topics on our site'
  end
end

