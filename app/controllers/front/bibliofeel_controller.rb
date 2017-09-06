class Front::BibliofeelController < FrontController
  include OwnedOpuses
  
  # layout 'opuses'

  respond_to :js, only: :filter

  before_filter :authenticate_user!

  def index
    participated_opuses_ids    = current_user.participated_opuses_ids
    owned_opuses_ids           = current_user.owned_opuses_ids
    library_entries_opuses_ids = current_user.library_entries_opuses_ids

    @opuses = {}
    @opuses[:participated_opuses] = Opus.filter({id: participated_opuses_ids, page: 1, order_attr: 'likes_count', order_val: 'asc'})
    @opuses[:marketplace]         = Opus.filter({id: owned_opuses_ids, page: 1, order_attr: 'likes_count', order_val: 'asc'})
    @opuses[:experience]          = Opus.filter({id: library_entries_opuses_ids, page: 1, order_attr: 'likes_count', order_val: 'asc'})
    @atmospheres = Atmosphere.used
    @play_times = PlayTime.used
    @keywords = Keyword.used
    @languages = Language.used
  end

  def filter
    if extra_params[:current_tab] == 'participated_opuses'
      opuses = current_user.participated_opuses_ids
    elsif extra_params[:current_tab] == 'marketplace'
      opuses = current_user.owned_opuses_ids
    elsif extra_params[:current_tab] == 'experience'
      opuses = current_user.library_entries_opuses_ids
    end  

    @replace_items      = presentation_params[:replace_items] == 'true'
    @participated       = extra_params[:participated] == 'true' ? true : false
    @remove             = extra_params[:remove] == 'true' ? true : false
    @replacement_target = extra_params[:current_tab]
    @opuses             = Opus.filter(filter_params.merge({id: opuses}))
  end

  def remove
    feellist     = Feellist.find_by(user_id: current_user.id)
    library_entry = LibraryEntry.find_by(feellist_id: feellist.id, opus_id: params[:id])
    library_entry.destroy

    redirect_to front_bibliofeel_path    
  end

  def leave
    collaboration = Collaboration.find_by(user_id: current_user.id, opus_id: params[:id])
    collaboration.destroy

    redirect_to front_bibliofeel_path
  end

  private

  def presentation_params
    params.require(:presentation).permit(:replace_items)
  end

  def extra_params
    params.require(:extra).permit(:current_tab, :remove, :participated)
  end

  def filter_params
    params.require(:filter).permit(:atmosphere_id, :play_time_id, :keyword_id, :language_id, :page, :order_attr, :order_val, :title)
  end
end
