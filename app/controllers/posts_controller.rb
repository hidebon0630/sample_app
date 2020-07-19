class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  before_action :already_voted_user, only: :show
  before_action :reject_current_user, only: :show

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.published.order('created_at DESC').page(params[:page]).per(10)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    end
  end

  def new
    @post = current_user.posts.build
    @option = current_user.options.build
  end

  def show
    @vote = current_user.votes.build
    impressionist(@post, nil, unique: [:session_hash.to_s])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      params[:options].each do |option|
        next unless option[:title] != ''
        new_option = current_user.options.build
        new_option.title = option[:title]
        new_option.post_id = @post.id
        new_option.save!
      end
      logger.info(@post)
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
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def pv
    @posts = Post.order(impressions_count: 'DESC').take(5)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :status, :tag_list)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def already_voted_user
    @post = Post.find(params[:id])
    voted = current_user.votes.find_by(post_id: params[:id])
    return if voted.nil?

    redirect_to post_votes_path(@post)
    flash[:notice] = '既に回答しています'
  end

  def reject_current_user
    post = Post.find_by(id: params[:id])
    if post.user == current_user
      redirect_back(fallback_location: posts_path)
      flash[:warning] = "自分で回答は出来ません"
    end
  end
end
