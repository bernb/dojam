# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # We use UserPolicy here to disallow the main admin account to remove itself
  def destroy
    @record = current_user
    authorize @user, policy_class: UserPolicy
    super
  end
end
