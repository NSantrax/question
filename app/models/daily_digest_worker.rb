class DailyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  requrense { daily(1) }

  def perform
    User.daily_mailer_digest
  end
end