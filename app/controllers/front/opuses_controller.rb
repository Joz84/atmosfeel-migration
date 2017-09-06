class Front::OpusesController < FrontController
  layout 'opuses'

  respond_to :js, only: :toggle_publish

  before_filter :authenticate_user_or_admin!
  before_filter :set_opus, except: [:new, :create]
  before_filter :set_resources, except: [:destroy, :create]
  before_filter :is_owner?, only: [:edit, :update, :toggle_publish, :destroy]
  before_filter :current_user_can_read, only: [:show, :read]
  before_filter :log_opus, only: [:show], if: :json_request?

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def read
    render layout: false
  end

  def new
    @opus = Opus.new
    @opus.collaborations.build
    chapters = @opus.chapters.build
    chapters.slider_entries.build
    @opus.keyword_opuses.build
    @opus.musics.build
    @opus.voices.build
  end

  def edit
  end

  def create
    @opus = Opus.new(sanitized_opus_params)
    @opus.user = current_user

    if @opus.save
      render json: @opus
    else
      if Rails.env.development?
        render text: @opus.errors.inspect
      else
        render json: '', status: 400
      end
    end
  end

  def update
    if @opus.update(sanitized_opus_params)
      render json: @opus
    else
      if Rails.env.development?
        render text: @opus.errors.inspect
      else
        render json: '', status: 400
      end
    end
  end

  def destroy
    @opus.destroy
    redirect_to front_bibliofeel_path, notice: 'Opus was successfully destroyed.'
  end

  def toggle_publish
    @opus.publish!
  end

  private

  # lib/devise/controllers/helpers 
  def authenticate_user_or_admin!(opts={})
    opts[:scope] = admin_signed_in? ? :admin : :user
    warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
  end

  def log_opus
    if !admin_signed_in?
      OpusLogger.log(@opus.id, current_user.id) if (current_user.owned_opuses_ids.include?(@opus.id) || (current_user.library_entries_opuses_ids.include?(@opus.id) && current_user.agreement_active?)) && !admin_signed_in?
    end
  end

  def json_request?
    request.format.symbol == :json
  end

  def current_user_can_read
    if !admin_signed_in?
      redirect_to front_bibliofeel_path if !(current_user.participated_opuses.include?(@opus) || current_user.owned_opuses_ids.include?(@opus.id) || (current_user.library_entries_opuses_ids.include?(@opus.id) && current_user.agreement_active?) || current_user.agreement_active?)
    end
  end

  def is_owner?
    if !admin_signed_in?
      redirect_to front_bibliofeel_path if @opus.user_id != current_user.id
    end
  end

  def set_resources
    @atmospheres = Atmosphere.all
    @play_times  = PlayTime.all
    @languages = Language.all
    @collaboration_types = CollaborationType.all
  end

  def set_opus
    @opus = Opus.find(params[:id])
  end

  def opus_params
    params.permit(
      :language_id, :title, :abstract, :local_file, :remove_cover, :font_color, :font_family, :price, :published, :atmosphere_id, :play_time_id, :isbn, :author_override,
      musics_attributes: [ :id, :local_file, :remove_file, :title, :_destroy ],
      voices_attributes: [ :id, :local_file, :remove_file, :title, :_destroy ],
      keyword_opuses_attributes: [ :id, :keyword_id, :_destroy ],
      collaborations_attributes: [ :id, :user_id, :collaboration_type_id, :_destroy ],
      chapters_attributes: [ :id, :position, :title, :content, :font_color, :local_file, :remove_background_image, :_destroy, slider_entries_attributes: [ :id, :local_file, :remove_file, :position, :_destroy ],
        musics_attributes: [ :id, :local_file, :remove_file, :title, :_destroy ],
        voices_attributes: [ :id, :local_file, :remove_file, :title, :_destroy ]
      ]
    )
  end

  def sanitized_opus_params
    opus_params_copy = opus_params
    if !opus_params_copy[:keyword_opuses_attributes].nil?
      opus_params_copy[:keyword_opuses_attributes] = opus_params_copy[:keyword_opuses_attributes].uniq { |keyword_opus| 
        keyword_opus[:keyword_id] 
      }
      opus_params_copy[:keyword_opuses_attributes] = opus_params_copy[:keyword_opuses_attributes].delete_if {|keyword_opus| 
        keyword_opus.empty? || keyword_opus.values.any? {|x| x.nil?}
      }
    end
    opus_params_copy
  end
end
