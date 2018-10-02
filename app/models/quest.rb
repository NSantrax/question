class Quest < ApplicationRecord
  
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  belongs_to :user
  accepts_nested_attributes_for :attachments
  
  validates :title, :body, presence: true
  validates_length_of :title, :within => 3..250
  validates_length_of :body, :within => 3..2000
  accepts_nested_attributes_for :attachments
end
