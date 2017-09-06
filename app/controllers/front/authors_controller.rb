class Front::AuthorsController < FrontController
  respond_to :js, only: :order

  before_filter :authenticate_user!, only: :contact

  def index
    @authors = User.artist_index
  end

  def contact
    recipient = User.find(params[:id])
    content   = contact_params[:content]
    if !content.empty? && recipient.accepts_contact
      ContactArtist.hello(recipient, current_user, contact_params[:content]).deliver_later 
    end
    redirect_to front_authors_path
  end

  def order
    @authors = User.artist_order_by(order_params)
  end

  def show
    @author             = User.find(params[:id])
    opuses              = @author.participated_opuses.partition{|opus| opus.atf_experience? }    
    @experience_opuses  = opuses[0]
    @marketplace_opuses = opuses[1]

    redirect_to front_authors_path if !@author.artist? 
  end

  private

  def contact_params
    params.require(:contact).permit(:content)
  end

  def order_params
    params.require(:order).permit(:attr, :val)
  end
end
