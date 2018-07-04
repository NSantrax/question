require 'rails_helper'


RSpec.describe Answer, :type => :model do
  describe 'validations' do
    it {should validate_presence_of :body}
    it {should validate_presence_of :quest_id}
    it {should validate_length_of(:body).is_at_least(3)} 
    it {should validate_length_of(:body).is_at_most(5000)}
  end
  describe 'associations' do
    it { should belong_to(:quest) }
  end
end
