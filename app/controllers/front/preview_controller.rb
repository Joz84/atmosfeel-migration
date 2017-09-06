class Front::PreviewController < FrontController
  layout false

  def show
    @opus = Opus.find(params[:id])
    first_chapter = @opus.chapters.first
    @chapters = [first_chapter]

    if first_chapter.nil?
      if @opus.atf_experience?
        redirect_to front_experience_product_path(@opus)
      else
        redirect_to front_marketplace_product_path(@opus)
      end
    else
      respond_to do |format|
        format.html
        format.json
      end
    end
  end
end
