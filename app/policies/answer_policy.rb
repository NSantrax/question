class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  

  def create?
    user
  end

  def update?
    user.admin? || user == record.user
  end

  def destroy?
    user.admin? || user == record.user
  end
end
