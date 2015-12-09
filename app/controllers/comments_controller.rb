class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create(comment_params)
    redirect_to user_path(id: @micropost.user_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
