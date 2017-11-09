module Api::V1
  class OpusesController < ApplicationController
    acts_as_token_authentication_handler_for User, except: [:index, :show]
    protect_from_forgery :except => [:index, :show]

    before_filter :set_opus, except: [:index]
    before_filter :log_opus, only: [:read]

    def index
      @user = User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
      @opuses = Opus.all #filter(opus_params)
    end

    def show
      @user = User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
    end

    def read
      # Retrieve user and verify if agreement is active
      user = User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
      if user && !user.agreement_active?
        return render status: 401, json: { message: "Vous devez disposer d'un compte actif" }
      end
    end

    def logs
      opus = OpusLog.new(user_id: current_user.id, opus_id: @opus.id)
      if opus.save
        render status: 204, json: nil
      else
        render json: opus.errors.to_hash
      end
    end

    def toggle_readed
      user_opuses = @opus.user_opuses.where(user: current_user)
      if user_opuses.any?
        user_opuses.destroy_all
        render status: 200, json: { message: "Toggled to unread" }
      else
        UserOpus.create(user: current_user, opus: @opus)
        render status: 200, json: { message: "Toggled to read" }
      end
    end

    private

    def opus_params
      params.permit(:atf_experience, :query, :atmosphere_id, :play_time_id, :language_id, :order_attr, :order_val, :page)
    end

    def set_opus
      @opus = Opus.find(params[:id])
    end

    def log_opus
      OpusLogger.log(@opus.id, current_user.id) if (current_user.owned_opuses_ids.include?(@opus.id) || (current_user.library_entries_opuses_ids.include?(@opus.id) && current_user.agreement_active?))
    end
  end
end
