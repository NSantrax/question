require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { create :user }
  let(:quest) { create :quest, user: user }
  let(:answer) { create :answer, quest: quest, user: user }

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

  permissions :destroy? do
    it "grants access if user is admin" do
      expect(subject).to permit(User.new(admin:true)), create(:comment, commentable: quest, user: user)
      expect(subject).to permit(User.new(admin:true)), create(:comment, commentable: answer, user: user)
    end
    it "grants access if user is author" do
      expect(subject).to permit(user, create(:comment, commentable: quest, user: user))
      expect(subject).to permit(user, create(:comment, commentable: answer, user: user))
    end
    it "denies access if user not author" do
      expect(subject).to_not permit(User.new, create(:comment, commentable: quest, user: user))
      expect(subject).to_not permit(User.new, create(:comment, commentable: answer, user: user))
    end
  end
end
