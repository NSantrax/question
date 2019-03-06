class Comment < ApplicationRecord
  include PgSearch
 
  after_save :reindex

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  multisearchable against: :body

  validates :body, presence: true
  
  private
  def reindex
    PgSearch::Multisearch.rebuild(Comment)
  end
end
