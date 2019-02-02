require 'rails_helper'


RSpec.describe Answer, :type => :model do
  let!(:user) { create(:user) }
  let!(:quest) { create(:quest, user: user)}
  subject {build(:answer, quest: quest, user: user)}
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
  describe 'publish answer' do
    it 'should publish answer after creating' do
      expect(subject).to receive(:publish_answer)
      subject.save!
    end
    it 'should not publish answer after updating' do
      subject.save!
      expect(subject).to_not receive(:publish_answer)
      subject.update(body: '12345')
    end
  end
end
