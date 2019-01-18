class ListAnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :attach, :quest
 
  has_many :comments
 
  def attach
    object.attachments.map { |a| a.file.url }   
  end
  def quest
    object.quest.title
  end
end
