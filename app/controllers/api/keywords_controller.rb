class Api::KeywordsController < ApiController
  def filter
    @keywords = Keyword.all # filter(keyword_params)
    respond_with :json
  end

  def create
    render json: Keyword.find_or_create_by(label: keyword_params)
  end

  def index
    render json: Keyword.all
  end

  private

  def keyword_params
    params.require(:label)
  end
end
