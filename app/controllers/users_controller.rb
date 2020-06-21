class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[following followers]
  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(20)
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end
end
