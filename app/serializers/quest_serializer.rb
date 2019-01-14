class QuestSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title, :attach

  has_many :answers
  has_many :comments


  def short_title
    object.title.truncate(10)
  end

  def attach
    object.attachments.map { |a| a.file.url }   
  end
end
