class MuseumObjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end

    def resolve
      if @user.has_extended_access
        scope.all
      else
        scope.museum(@user.museum)
      end
    end
  end
end