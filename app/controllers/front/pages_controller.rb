class Front::PagesController < FrontController
  layout 'front'

  def index
    @news        = Opus.experience.news
    @selection   = Opus.experience.selection
    @popularity  = Opus.experience.popularity
    @atmospheres = Atmosphere.used
    @play_times  = PlayTime.all
    @keywords    = Keyword.all
  end

  def home
    @user        = User.new
    @atmospheres = Atmosphere.used
    @play_times  = PlayTime.used
    
    # temporary crap
    begin
      @opusTop = Opus.find(151)
    rescue
      @opusTop = nil
    end
    

    # temporary crap
    begin
      @opusBottom = Opus.find(130)
    rescue
      @opusBottom = nil
    end

    render layout: 'home'
  end

  # sometimes we have to define a method 
  # sometimes not, may be related to the dash
  def nous_parlons_de_vous
  end

  def mentions_legales
  end

  def ccm
  end
end