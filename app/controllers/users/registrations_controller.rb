class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :position)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :position)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(_resource)
    show_user_path
  end
end
