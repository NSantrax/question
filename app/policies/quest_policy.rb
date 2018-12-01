class QuestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def create?
    user
  end

  def update?
    if user
      user.admin? || user == record.user
    end
  end

  def destroy?
    if user
      user.admin? || user == record.user
    end
  end
end
