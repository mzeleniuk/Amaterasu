class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create(comment_params)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_path(id: @micropost.user_id) }
        format.js
      end
    else
      render js: "swal({title: 'Your comment is blank!', type: 'error'});"
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_path(id: @micropost.user_id) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def correct_user
    @comment = current_user.comments.find(params[:id])
    redirect_to root_url if @comment.nil?
  end
end
