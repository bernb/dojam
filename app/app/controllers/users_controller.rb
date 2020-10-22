class UsersController < ApplicationController
  def active_for_authentication?
    super && is_enabled?
  end

  def inactive_message
    is_enabled? ? super : t('your account is not yet enabled')
  end

  def switch_locale
    locale = params[:locale]
    if locale.in? ["ar", "en"]
      current_user.locale = locale
      current_user.save
    end
    redirect_back fallback_location: :root
  end
end
