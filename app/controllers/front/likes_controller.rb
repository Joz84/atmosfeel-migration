class Front::LikesController < FrontController
  include OwnedOpuses

  before_filter :authenticate_user!

  respond_to :js

  def index
    @opuses      = current_user.liked_library_entries
    @atmospheres = Atmosphere.used
    @play_times  = PlayTime.used
    @languages   = Language.used
  end

  def create
    if current_user.like?(params[:id])
      current_user.unlike(params[:id])
    else
      current_user.like(params[:id])
    end
    @likes_count = Opus.find(params[:id]).likes_count
  end

  def filter
    @replace_items = presentation_params[:replace_items] == 'true'
    @opuses        = current_user.liked_library_entries(filter_params)

    render 'front/catalog/filter', layout: false
  end

  private

  def presentation_params
    params.require(:presentation).permit(:replace_items)
  end

  def filter_params
    params.require(:filter).permit(:atmosphere_id, :play_time_id, :keyword_id, :language_id, :page, :order_attr, :order_val, :title)
  end
end
