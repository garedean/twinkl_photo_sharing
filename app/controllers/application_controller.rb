class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :has_avatar?
  # before_save :upload_images


  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || edit_user_registration_path
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :avatar)}
  end

  def has_avatar?
    current_user.avatar.file?
  end
end
