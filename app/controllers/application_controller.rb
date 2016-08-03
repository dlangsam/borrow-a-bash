class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :add_extra_params, if: :devise_controller?

  protected

  def add_extra_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :zip_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name,
    	:address1, :address2, :city, :state, :zip_code])
  end
end
