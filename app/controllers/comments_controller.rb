class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find_by(id: params[:post_id])
    @comments = @post.comments
    return unless @comment.save

    @post.create_notification_comment!(current_user, @comment.id)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
