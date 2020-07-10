class VotesController < ApplicationController
  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      redirect_back(fallback_location: root_path)
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
