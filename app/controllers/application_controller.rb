class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ログイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource)
    edit_user_registration_path # /user/edit へのパス
  end
end
