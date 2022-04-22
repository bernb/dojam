class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :main_account_must_exist, except: [:new_main_account, :create_main_account]
  before_action :authenticate_user!, except: [:new_main_account, :create_main_account] # Method implemented by devise
  before_action :normal_users_must_belong_to_a_museum, except: [:new_main_account, :create_main_account, 'sessions#new']
  around_action :set_locale

  def default_url_options
    if user_signed_in?
      return super
    end
    {locale: I18n.locale}
  end

  def check_extended_access!
    unless current_user.has_extended_access?
      flash[:danger] = t('not_authorized_you_need_extended_access_to_do_this')
      redirect_to root_path
    end
  end

  private

  def normal_users_must_belong_to_a_museum
    if current_user.present? &&
      current_user.is_normal_user? &&
      current_user.museum.nil?
      flash[:danger] = t('account_must_be_assigned_to_a_museum')
      sign_out(current_user)
      redirect_to new_user_session_path
    end
  end

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
