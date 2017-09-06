class Back::OpusesController < BackController
  before_action :set_opus, except: :index

  def index
    @opuses = Opus.all
  end

  def edit
  end

  def read
    render '/front/opuses/read', layout: false
  end

  def update
    if @opus.update(opus_params)
      redirect_to back_opuses_path, notice: 'Opus was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def duplicate
    @users     = User.all
    @atmosfeel = User.find_by_email('plongez@experience-atmosfeel.com')
  end

  def create_copy
    opus_copy = @opus.deep_clone except: [:isbn, :likes_count], include: [
      :keyword_opuses,
      :collaborations,
      {chapters: [
        :slider_entries,
        :musics,
        :voices
      ]},
      :musics,
      :voices
    ] do |original, kopy|
      kopy.local_file = original.cover_url if original.respond_to?(:cover_url)
      kopy.local_file = original.file_url if original.respond_to?(:file_url)
      kopy.local_file = original.background_image_url if original.respond_to?(:background_image_url)
    end

    opus_copy.update(copy_params)

    if opus_copy.atf_experience
      redirect_to front_experience_product_path(opus_copy)
    else
      redirect_to front_marketplace_product_path(opus_copy)
    end
  end

  def destroy
    @opus.destroy
    redirect_to back_opuses_path, notice: 'Opus was successfully destroyed.'
  end

  private

  def set_opus
    @opus = Opus.find(params[:id])
  end

  def opus_params
    params.require(:opus).permit(:atf_experience, :published, :selected, :isbn, :flagged)
  end

  def copy_params
    params.require(:opus).permit(:user_id, :atf_experience, :published, :selected, :flagged)
  end
end
