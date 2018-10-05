require 'rails_helper'


RSpec.describe Answer, :type => :model do
  describe 'validations' do
    it {should belong_to :quest}
    it {should have_many :attachments}
    it {should validate_presence_of :body}
    it {should validate_presence_of :quest_id}
    it {should validate_length_of(:body).is_at_least(3)} 
    it {should validate_length_of(:body).is_at_most(5000)}
    it {should accept_nested_attributes_for :attachments}
  end
  describe 'associations' do
    it { should belong_to(:quest) }
  end
end
