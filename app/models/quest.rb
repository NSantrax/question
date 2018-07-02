class Quest < ApplicationRecord
  validates :title, :body, presence: true
end
