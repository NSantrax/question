class DailyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily(1) }

  def perform
    User.find_each.each do |user|
      DailyMailer.digest(user)#.deliver_later#.deliver_now
    end
  end
end