class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :danger, :info, :warning, :success, :primary

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username first_name last_name email password avatar private])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email password avatar private])
  end

  private

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
