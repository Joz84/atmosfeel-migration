module Api::V1
  class CommentsController < ApplicationController
    acts_as_token_authentication_handler_for User, except: [ :index ]
    protect_from_forgery :except => :create

    before_action :set_opus

    def index
      @comments = @opus.comments
    end

    def create
      full_params = comment_params.merge({user: current_user})
      @comment = @opus.comments.build(full_params)
      if @comment.save
        @comments = @opus.comments
        render :index
      else
        render json: @comment.errors.to_hash
      end
    end

    private

    def comment_params
      params.permit(:content)
    end

    def set_opus
      @opus = Opus.find(params[:id])
    end
  end
end
