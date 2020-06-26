class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
