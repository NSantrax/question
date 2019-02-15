class AnswerNewWorker
  include Sidekiq::Worker

  def perform(answer)
    @answer = answer
    AnswersMailer.new_answer(@answer)
    AnswersMailer.subscribers(@answer)
  end
end