class Answer < ApplicationRecord
  
  belongs_to :quest
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  
  accepts_nested_attributes_for :attachments
  
  validates :body, presence: true
  validates :quest_id, presence: true
  validates_length_of :body, :within => 3..5000
end
