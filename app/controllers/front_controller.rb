class FrontController < ApplicationController
  before_filter :open_menu
  after_filter :store_action

  layout 'front'

  private

  def store_action
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

  protected

  # deal with this strange menu when the user logged in
  def open_menu
    if user_signed_in? && session[:open_menu].nil?
      session[:open_menu] = true
    elsif user_signed_in? && session[:open_menu]
      session[:open_menu] = false
    elsif !user_signed_in?
      session[:open_menu] = nil
    end
  end
end
