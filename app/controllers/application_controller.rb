class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :add_extra_params, if: :devise_controller?

  protected

  def add_extra_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
