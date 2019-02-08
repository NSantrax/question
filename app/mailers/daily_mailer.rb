class DailyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_mailer.digest.subject
   
  #
  def digest(user)
    @user = user
    @greeting = "Dear User!"
    @quests = Quest.where('created_at > ? AND created_at <= ?', Time.zone.now - 1.day, Time.zone.now).pluck(:title, :body)

    mail(to: @user.email, subject: "New questions")
  end
end
