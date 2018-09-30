class Attachment < ActiveRecord::Base
  belongs_to :quest
  mount_uploader :file, FileUploader
  
end
