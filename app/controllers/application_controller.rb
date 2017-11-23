class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_section

  def after_sign_in_path_for(resource)
      '/ankens'
  end

  def user_section
    @user_section ||= Section.find_by(section_cd: current_user.section_id)
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :section_id, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email, :section_id, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :section_id, :password, :password_confirmation])
    end
end
