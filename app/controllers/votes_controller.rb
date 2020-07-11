class VotesController < ApplicationController

  def show
    @post = Post.find(params[:post_id])
    @votes = @post.votes
    @chart = @votes.group(:option_id).count
    @comments = @post.comments
    @comment = current_user.comments.build
  end

  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      redirect_to post_votes_path
      flash[:notice] = "回答ありがとうございました！"
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = "回答は一人一回までです。"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :post_id, :option_id)
  end
end
