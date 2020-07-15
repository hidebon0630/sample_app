class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      flash[:notice] = 'コメントを送信しました。'
      redirect_back(fallback_location: root_path)
      @post.create_notification_comment!(current_user, @comment.id)
    else
      flash[:notice] = 'コメントに失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
