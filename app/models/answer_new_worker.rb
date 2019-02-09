class AnswerNewWorker
  include Sidekiq::Worker

  def perform(answer)
    @answer = answer
    AnswersMailer.new_answer(@answer)
  end
end