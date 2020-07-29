class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :yet_voted_user, only: :show

  def show
    @options = @post.options
    @votes = @post.votes
    @comments = @post.comments.includes(:user)
    @comment = current_user.comments.build
    gon.options = @votes.eager_load(:option).pluck(:title)
    gon.data = []
    votes_count = @votes.group(:option_id).count
    gon.array = votes_count.values
    gon.array.each do | data |
      gon.data << data
    end
  end

  def create
    @vote = current_user.votes.build(vote_params)
    @post = @vote.post
    if @vote.save
      @post.create_notification_vote!(current_user, @vote.id)
      redirect_to post_votes_path
      flash[:notice] = '回答ありがとうございました'
    else
      redirect_back(fallback_location: posts_path)
      flash[:warning] = '項目を入力して下さい'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :post_id, :option_id)
  end

  def yet_voted_user
    @post = Post.find(params[:post_id])
    voted = current_user.votes.find_by(post_id: params[:post_id])
    return unless @post.user != current_user

    return unless voted.nil?

    redirect_back(fallback_location: posts_path)
    flash[:warning] = '回答後のみ結果を確認出来ます'
  end
end
