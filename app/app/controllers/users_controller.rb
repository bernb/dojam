class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def switch_locale locale
    if locale.in? ["ar", "en"]
      current_user.locale = locale
    end
    redirect_to root
  end
end
