class Answer < ApplicationRecord
  
  belongs_to :quest
  belongs_to :user
 
  validates :body, presence: true
  validates :quest_id, presence: true
  validates_length_of :body, :within => 3..5000
end
