class AnswersMailer < ApplicationMailer

  def new_answer (user, answer)
    @user = user
    @answer = answer
    mail(to: @user.email, subject: 'Created new answer' )
  end
end
