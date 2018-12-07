class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      #user ||= User.new # guest user (not logged in)
      gest_abilities
    end
  end
  def gest_abilities
     can :read, :all
  end
  def admin_abilities
    can :manage, :all
  end
  def user_abilities(user)
    gest_abilities
    can :create, [Quest, Answer, Comment]
    can :update, [Quest, Answer], user: user
    can :destroy, [Quest, Answer, Comment], user: user
  end 
end
