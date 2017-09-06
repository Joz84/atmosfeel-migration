class Back::PlayTimesController < BackController
  before_action :set_play_time, only: [:edit, :update, :destroy]

  def index
    @play_times = PlayTime.all
  end

  def new
    @play_time = PlayTime.new
  end

  def edit
  end

  def create
    @play_time = PlayTime.new(play_time_params)

    if @play_time.save
      redirect_to back_play_times_path, notice: 'Play time was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @play_time.update(play_time_params)
      redirect_to back_play_times_path, notice: 'Play time was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @play_time.destroy
    redirect_to back_play_times_path, notice: 'Play time was successfully destroyed.'
  end

  private

  def set_play_time
    @play_time = PlayTime.find(params[:id])
  end

  def play_time_params
    params.require(:play_time).permit(:label)
  end
end
