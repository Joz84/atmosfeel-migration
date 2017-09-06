class ApiController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  protect_from_forgery with: :null_session
end
