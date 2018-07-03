class Quest < ApplicationRecord
  
  has_many :answers, dependent: :destroy
  
  validates :title, :body, presence: true
  validates_length_of :title, :within => 3..250
  validates_length_of :body, :within => 3..2000
end
