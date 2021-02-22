class PublicationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
  	true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def edit?
    update?
  end

  def new?
    create?
  end

  def destroy?
    record.user == user
  end
end
