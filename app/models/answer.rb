class Answer < ApplicationRecord
  
  belongs_to :quest
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  
  
  accepts_nested_attributes_for :attachments


  validates :body, presence: true
  validates :quest_id, presence: true
  validates_length_of :body, :within => 3..5000
  after_create :publish_answer
  after_create :send_notification 

  private
  def publish_answer
    #self.publish_answer
    #@answer = Answer.last
    #@quest = @answer.quest
    PrivatePub.publish_to "/quests/#{self.quest.id}/answers", answer: self.to_json
  end

  def send_notification
    
    @user = self.quest.user
    AnswersMailer.new_answer(@user, self).deliver_now
  end
end
