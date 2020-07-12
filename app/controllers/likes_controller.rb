class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @post.create_notification_like!(current_user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.js
    end
  end
end
