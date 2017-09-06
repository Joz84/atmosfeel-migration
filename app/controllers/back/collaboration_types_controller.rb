class Back::CollaborationTypesController < BackController
  before_action :set_collaboration_type, only: [:edit, :update, :destroy]

  def index
    @collaboration_types = CollaborationType.all
  end

  def new
    @collaboration_type = CollaborationType.new
  end

  def edit
  end

  def create
    @collaboration_type = CollaborationType.new(collaboration_type_params)

    if @collaboration_type.save
      redirect_to back_collaboration_types_path, notice: 'Collaboration type was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @collaboration_type.update(collaboration_type_params)
      redirect_to back_collaboration_types_path, notice: 'Collaboration type was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @collaboration_type.destroy
    redirect_to back_collaboration_types_path, notice: 'Collaboration type was successfully destroyed.'
  end

  private

  def set_collaboration_type
    @collaboration_type = CollaborationType.find(params[:id])
  end

  def collaboration_type_params
    params.require(:collaboration_type).permit(:label)
  end
end
