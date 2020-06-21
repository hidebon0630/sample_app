class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.page(params[:page]).per(20)
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
