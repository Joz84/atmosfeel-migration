class Back::AtmospheresController < BackController
  before_action :set_atmosphere, only: [:edit, :update, :destroy]

  def index
    @atmospheres = Atmosphere.all
  end

  def new
    @atmosphere = Atmosphere.new
  end

  def edit
  end

  def create
    @atmosphere = Atmosphere.new(atmosphere_params)

    if @atmosphere.save
      redirect_to back_atmospheres_path, notice: 'Atmosphere was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @atmosphere.update(atmosphere_params)
      redirect_to back_atmospheres_path, notice: 'Atmosphere was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @atmosphere.destroy
    redirect_to back_atmospheres_path, notice: 'Atmosphere was successfully destroyed.'
  end

  private

  def set_atmosphere
    @atmosphere = Atmosphere.find(params[:id])
  end

  def atmosphere_params
    params.require(:atmosphere).permit(:label, :color)
  end
end
