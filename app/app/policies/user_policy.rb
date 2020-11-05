class UserPolicy < ApplicationPolicy
  def update?
    return false
    # Only main admin account is allowed to change itself
    if @record.id == 1
      if @user.id == 1
        return true
      else
        return false
      end
    end
    return @user.has_extended_access
    end

  def destroy?
    # Never delete main admin
    if @record.id == 1
      return false
    else
      update?
    end
  end
end