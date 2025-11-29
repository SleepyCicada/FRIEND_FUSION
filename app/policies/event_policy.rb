class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && record.user == user
  end
end
