class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      '/ankens'
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation])
    end
end
