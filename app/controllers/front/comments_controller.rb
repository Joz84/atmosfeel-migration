class Front::CommentsController < FrontController
  before_filter :authenticate_user!

  def create
    opus = Opus.find(params[:opus_id])
    opus.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to(:back)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
