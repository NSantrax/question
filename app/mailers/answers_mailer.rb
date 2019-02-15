class AnswersMailer < ApplicationMailer

  def new_answer(answer)
    @answer = answer
    @user = @answer.quest.user
    mail(to: @user.email, subject: 'Created new answer' )
  end

  def subscribers(answer)
    @answer = answer
    @answer.quest.users.each do |u|
      mail(to: u.email, subject: "Created new answer to #{@answer.quest.title}" )
    end
  end

end
