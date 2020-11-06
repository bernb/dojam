class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :main_account_must_exist, except: [:new_main_account, :create_main_account]
  before_action :authenticate_user!, except: [:new_main_account, :create_main_account]
  around_action :set_locale

  def default_url_options
    if user_signed_in?
      return super
    end
    {locale: I18n.locale}
  end

  def check_extended_access!
    unless current_user.has_extended_access?
      flash[:danger] = t('not authorized. You need extended access to do this.')
      redirect_to root_path
    end
  end

  private

  def main_account_must_exist
    redirect_to main_account_new_path unless User.find_by(id: 1).present?
  end

  def set_locale(&action)
    locale = current_user.try(:locale) || params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
