class VotesController < ApplicationController
  before_action :yet_voted_user, only: :show

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

  def yet_voted_user
    @post = Post.find(params[:post_id])
    voted = current_user.votes.find_by(post_id: params[:post_id])
    if voted.nil?
      redirect_back(fallback_location: root_path)
      flash[:notice] = "回答後のみ結果を確認出来ます。"
    end
  end
end
