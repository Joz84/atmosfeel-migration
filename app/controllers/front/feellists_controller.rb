class Front::FeellistsController < FrontController
  before_filter :authenticate_user!
  before_filter :agreement_active?

  def add
    current_user.default_feellist.add_library_entry(params[:id])
    redirect_to front_bibliofeel_path(anchor: 'experience')
  end

  private

  def agreement_active?
    redirect_to front_tarifs_path if !current_user.agreement_active?
  end
end
