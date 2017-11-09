module Api::V1
  class BibliofeelController < ApplicationController
    acts_as_token_authentication_handler_for User
    protect_from_forgery :except => :index

    def index
      @bibliofeel = current_user.opuses #.filter(bibliofeel_params)
    end

    private

    def bibliofeel_params
      params.permit(:atf_experience, :query, :atmosphere_id, :play_time_id, :language_id, :order_attr, :order_val, :page)
    end
  end
end
