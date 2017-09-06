module Api::V1
  class SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token
    skip_before_filter :verify_signed_out_user

    acts_as_token_authentication_handler_for User

    def create
      email = params[:email]
      password = params[:password]

      if email.nil? or password.nil?
        render status: 400, json: { message: 'The request MUST contain the user email and password.' }
        return
      end

      user = User.find_by(email: email)

      if user && user.valid_password?(password)
        user.authentication_token = nil
        user.save
        render status: 200, json: { id: user.id, email: user.email, authentication_token: user.authentication_token, active_subscription: user.agreement_active? }
      else
        render status: 401, json: { errors: 'Invalid email or password.' }
      end
    end

    def destroy
      user = current_user
      if user
        user.authentication_token = nil
        user.save
        render status: 200, json: { message: 'Disconnected' }
      else
        render status: 404, json: { message: 'Invalid User.' }
      end
    end
  end
end
