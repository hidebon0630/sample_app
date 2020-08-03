class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  before_action lambda {
    set_post
    already_voted_user
    reject_current_user
  }, only: :show

  def index
    @q = Post.ransack(params[:q])
    @posts = if params[:tag_name]
               Post.includes(:taggings, :user).tagged_with(params[:tag_name].to_s).page(params[:page]).per(10)
             else
               @q.result.includes(:taggings, :user).order('created_at DESC').page(params[:page]).per(10)
             end
  end

  def new
    @post = current_user.posts.build
    num = 0
    while num < 2
      @post.options.build
      num += 1
    end
  end

  def show
    @vote = current_user.votes.build
    impressionist(@post, nil, unique: [:session_hash.to_s])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = '投稿が完了しました'
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_back(fallback_location: posts_path)
  end

  def favorite
    @posts = Post.includes(:taggings, :user).find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(5).pluck(:post_id))
  end

  def pv
    @posts = Post.includes(:taggings, :user).order(impressions_count: 'DESC').take(5)
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :tag_list, options_attributes: %i[id title _destroy user_id])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def already_voted_user
    voted = current_user.votes.find_by(post_id: params[:id])
    return if voted.nil?

    redirect_to post_votes_path(@post)
    flash[:notice] = '既に回答しています'
  end

  def reject_current_user
    return unless @post.user == current_user

    redirect_back(fallback_location: posts_path)
    flash[:warning] = '自分で回答は出来ません'
  end
end
