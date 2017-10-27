class Front::CatalogController < FrontController
  include OwnedOpuses

  before_filter :like_opus, only: :show
  before_filter :authenticate_user!, only: :flag

  respond_to :js, only: :filter

  def index
    # if params[:filter].nil?
    #   @opuses = Opus.filter({page: 1, atf_experience: opuses_experience_param, order_attr: 'likes_count', order_val: 'asc'})
    # else
    #   @opuses = Opus.filter(filter_params.merge({page: 1, atf_experience: opuses_experience_param}))
    # end
    # @opuses = pre_filtered_opuses.page(params[:page])
    @opuses = pre_filtered_opuses.order(created_at: :desc).page(params[:page])
    @atmospheres = Atmosphere.used
    @play_times = PlayTime.used
    @languages = Language.used
  end

  def filter
    @replace_items = presentation_params[:replace_items] == 'true'
    # @opuses = pre_filtered_opuses.page(params[:page])
    @opuses = pre_filtered_opuses.order(created_at: :desc).page(params[:page])
    #@opuses = Opus.filter(filter_params.merge({atf_experience: opuses_experience_param}))
  end

  def flag
    @opus = Opus.find(params[:id])
    @opus.update(flagged: true)
    redirect_to(:back)
  end

  def show
    @opus = Opus.show(params[:id])

    if @opus.atf_experience && !params[:controller].include?('front/experience')
      redirect_to front_experience_product_path(@opus.id)
    elsif !@opus.atf_experience && !params[:controller].include?('front/marketplace')
      redirect_to front_marketplace_product_path(@opus.id)
    end

    @comments = @opus.comments.ordered
    @comment = Comment.new
  end

  private

  def like_opus
    if user_signed_in?
      @like_opus = current_user.like?(params[:id])
    else
      @like_opus = false
    end
  end

  def pre_filtered_opuses
    raise NotImplementedError
  end

  def opuses_experience_param
    raise NotImplementedError
  end

  def presentation_params
    params.require(:presentation).permit(:replace_items)
  end

  def filter_params
    params.require(:filter).permit(:atmosphere_id, :play_time_id, :keyword_id, :language_id, :page, :order_attr, :order_val, :title)
  end
end
