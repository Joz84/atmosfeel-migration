class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u|
  #     u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :cgv, :accepts_newsletter)
  #   }
  # end

  def configure_permitted_parameters
    user_data = [
      :firstname,
      :lastname,
      :email,
      :password,
      :password_confirmation,
      :cgv,
      :accepts_newsletter
    ]

    devise_parameter_sanitizer.permit(:sign_up, keys: user_data)
    devise_parameter_sanitizer.permit(:account_update, keys: user_data)
  end

end
