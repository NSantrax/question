require 'rails_helper'

 
  describe Ability do
    subject(:ability) {Ability.new(user)}
    describe 'for_guest' do
      let(:user) { nil }
      it {should be_able_to :read, Quest }
      it {should be_able_to :read, Answer }
      it {should be_able_to :read, Comment }

      it {should_not be_able_to :manage, :all }
    end

    describe 'for_user' do
      let(:user) { create :user }
      let(:other) { create :user }
      let(:quest) { create :quest, user: user }
      
      it {should be_able_to :create, Quest }
      it {should be_able_to :create, Answer }
      it {should be_able_to :create, Comment }
      it {should_not be_able_to :manage, :all }
      it {should be_able_to :update, create(:quest, user: user), user: user }
      it {should_not be_able_to :update, create(:quest, user: other), user: user }
      it {should be_able_to :update, create(:answer, quest: quest, user: user), user: user }
      it {should_not be_able_to :update, create(:answer, quest: quest, user: other), user: user }
      it {should be_able_to :destroy, create(:quest, user: user), user: user }
      it {should_not be_able_to :destroy, create(:quest, user: other), user: user }
      it {should be_able_to :destroy, create(:answer, quest: quest, user: user), user: user }
      it {should_not be_able_to :destroy, create(:answer, quest: quest, user: other), user: user }
      it {should be_able_to :destroy, create(:comment, commentable: quest, user: user), user: user }
      it {should_not be_able_to :destroy, create(:comment, commentable: quest, user: other), user: user }
    end
    describe 'for_admin' do
      let(:user) { create :user, admin: true }
      
      it {should be_able_to :read, :all }
      it {should be_able_to :manage, :all }
      

    end
  end

