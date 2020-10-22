class UsersController < ApplicationController
  def switch_locale
    locale = params[:locale]
    if locale.in? ["ar", "en"]
      current_user.locale = locale
      current_user.save
    end
    redirect_back fallback_location: :root
  end
end
