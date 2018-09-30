require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'validations' do
    it {should have_many :answers}
    it {should have_many :attachments}
    it {should validate_presence_of :body}
    it {should validate_presence_of :title}
    it {should validate_length_of(:body).is_at_least(3)} 
    it {should validate_length_of(:body).is_at_most(2000)}
    it {should validate_length_of(:title).is_at_least(3)} 
    it {should validate_length_of(:title).is_at_most(250)}
    it {should accept_nested_attributes_for :attachments}
  end
end


