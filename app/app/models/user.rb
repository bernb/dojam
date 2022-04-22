class User < ApplicationRecord
  belongs_to :museum, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && is_enabled?
  end

  def inactive_message
    is_enabled? ? super : I18n.t('your_account_is_not_yet_enabled')
  end

  def show_museum_for_objects?
    return self.has_extended_access?
  end

  def is_normal_user?
    return !self.has_extended_access?
  end
end
