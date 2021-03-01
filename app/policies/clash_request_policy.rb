class ClashRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || record.publication.user == user
  end

  def create?
    if ClashRequest.where({user: user, publication: @publication}) == []
      true
    else
      false
    end
    
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user || record.publication.user == user
  end

end
