class ClashPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.clash_request.publication.user == user
  end

end
