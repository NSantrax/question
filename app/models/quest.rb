class Quest < ApplicationRecord
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :body]
  
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  belongs_to :user
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :comments
  has_many :subscriptions, foreign_key: :post_id, dependent: :destroy
  has_many :users, through: :subscriptions, dependent: :destroy
  
  validates :title, :body, presence: true
  validates_length_of :title, :within => 3..250
  validates_length_of :body, :within => 3..2000

  #after_create :send_author

  
end
