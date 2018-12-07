require 'rails_helper'

RSpec.describe AnswerPolicy do
  let(:user) { create :user }
  let(:quest) { create :quest, user: user }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  

  permissions :create? do
    it "grants access if user log_in" do
      expect(subject).to permit(user)
    end
    it "grants access if user log_out" do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :update?, :destroy? do
    it "grants access if user is admin" do
      expect(subject).to permit(User.new(admin:true)), create(:answer, quest: quest, user: user)
    end
    it "grants access if user is author" do
      expect(subject).to permit(user, create(:answer, quest: quest, user: user))
    end
    it "denies access if user not author" do
      expect(subject).to_not permit(User.new, create(:answer, quest: quest, user: user))
    end
  end

end
