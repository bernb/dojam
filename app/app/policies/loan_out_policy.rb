class LoanOutPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.has_extended_access?
        scope.all
      else
        scope.museum(user.museum)
      end
    end

    private
    attr_reader :user, :scope
  end
end
