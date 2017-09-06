class Front::UsersController < FrontController
  before_filter :authenticate_user!

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in(@user, bypass: true)
    end
    redirect_to front_profile_path
  end

  private

  def user_params
    if params[:user][:password].empty?
      params.require(:user).permit(:firstname, :lastname, :email, :phone, :address, :accepts_newsletter)
    else
      params.require(:user).permit(:firstname, :lastname, :email, :phone, :address, :password, :password_confirmation, :accepts_newsletter)
    end
  end
end
