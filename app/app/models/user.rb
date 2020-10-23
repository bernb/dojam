class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && is_enabled?
  end

  def inactive_message
    is_enabled? ? super : I18n.t('your account is not yet enabled')
  end
end
