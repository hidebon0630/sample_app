class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :correct_user, only: :destroy

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.published.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @post = current_user.posts.build
    @option = current_user.options.build
  end

  def show
    @post = Post.find(params[:id])
    @votes = @post.votes
    @vote = current_user.votes.build
    impressionist(@post, nil, :unique => [:session_hash.to_s])
    @comments = @post.comments
    @comment = current_user.comments.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      params[:options].each do |option|
        if option[:title] != ""
          new_option = Option.new
          new_option.title = option[:title]
          new_option.post_id = @post.id
          new_option.user_id = current_user.id
          new_option.save!
        end
      end
      flash[:success] = '投稿が完了しました'
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_back(fallback_location: root_url)
  end

  def ranking
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def pv
    @posts = Post.order('impressions_count DESC').take(3)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :tag_list, :status)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
