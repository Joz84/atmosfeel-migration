class Front::SettingsController < FrontController
  layout 'opuses'

  before_filter :set_bank_detail, only: [:bank, :update_bank]  

  def profile
    @user = current_user
  end

  def update_profile
    current_user.update(user_params)
    redirect_to front_profile_path
  end

  def toggle_artist
    current_user.toggle(:artist).save
    redirect_to front_profile_path
  end

  def toggle_accepts_contact
    current_user.toggle(:accepts_contact).save
    redirect_to front_profile_path
  end

  def bank
  end

  def update_bank
    @bank_detail.update(bank_detail_params)
    redirect_to front_bank_path
  end

  private

  def set_bank_detail
    @bank_detail = current_user.bank_detail
    @bank_detail = current_user.build_bank_detail if @bank_detail.nil?
  end

  def bank_detail_params
    params.require(:bank_detail).permit(:iban, :bic, :owner_firstname, :owner_lastname, :owner_address)
  end

  def user_params
    params.require(:user).permit(:nickname, :resume, :avatar)
  end
end
