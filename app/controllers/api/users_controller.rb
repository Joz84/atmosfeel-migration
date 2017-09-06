class Api::UsersController < ApiController
  def filter
    render json: User.artist.filter(user_params)
  end

  private

  def user_params
    params.require(:query)
  end
end
