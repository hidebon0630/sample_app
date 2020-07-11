class VotesController < ApplicationController

  def show
    @post = Post.find(params[:post_id])
    @votes = @post.votes
  end

  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      redirect_to vote
    else
      flash[:notice] = "投票は一回までです。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :post_id, :option_id)
  end
end
