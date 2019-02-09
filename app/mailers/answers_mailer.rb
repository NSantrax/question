class AnswersMailer < ApplicationMailer

  def new_answer(answer)
    @answer = answer
    @user = @answer.quest.user
    mail(to: @user.email, subject: 'Created new answer' )
  end
end
