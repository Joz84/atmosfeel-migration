class Back::KeywordsController < BackController
  before_action :set_keyword, only: [:edit, :update, :destroy]

  def index
    @keywords = Keyword.all
  end

  def new
    @keyword = Keyword.new
  end

  def edit
  end

  def create
    @keyword = Keyword.new(keyword_params)

    if @keyword.save
      redirect_to back_keywords_path, notice: 'Keyword was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @keyword.update(keyword_params)
      redirect_to back_keywords_path, notice: 'Keyword was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @keyword.destroy
    redirect_to back_keywords_path, notice: 'Keyword was successfully destroyed.'
  end

  private

  def set_keyword
    @keyword = Keyword.find(params[:id])
  end

  def keyword_params
    params.require(:keyword).permit(:label)
  end
end
