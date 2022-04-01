class AdminLinksPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    user.present? && user.has_extended_access?
  end
end