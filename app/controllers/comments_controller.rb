class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    redirect_back(fallback_location: root_path) if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
