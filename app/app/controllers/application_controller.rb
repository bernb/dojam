class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  around_action :set_locale

  def check_extended_access!
    unless current_user.has_extended_access?
      flash[:danger] = t('not authorized. You need extended access to do this.')
      redirect_to root_path
    end
  end

  def set_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
