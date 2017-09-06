module Api::V1
  class LikesController < ApplicationController
    acts_as_token_authentication_handler_for User
    protect_from_forgery :except => :create

    def create
      @opus = Opus.find(params[:id])
      like = @opus.likes.new(user: current_user)
      if like.save
        render :create
      else
        render json: like.errors.to_hash
      end
    end
  end
end
