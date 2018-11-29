class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      if user.admin?
        admin_abilities
      else       
        user_abilities 
      end
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
  def user_abilities
    gest_abilities
    can :create, [Quest, Answer, Comment]
    can :update, [Quest, Answer], user: user
    can :delate, [Quest, Answer], user: user
  end 
end
