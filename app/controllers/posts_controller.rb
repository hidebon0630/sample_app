class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

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

  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
