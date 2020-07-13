class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[following followers]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end

  def show
    @user = User.find_by(id: params[:id])
    @following = @user.following.page(params[:page]).per(10)
    @followers = @user.followers.page(params[:page]).per(10)
    @posts = @user.posts.published.page(params[:page]).per(10)
    @draft_posts = @user.posts.draft.page(params[:page]).per(10)
    @liked_posts = @user.liked_posts.page(params[:page]).per(10)
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    return if @user.id == current_user.id

    @current_user_entry.each do |cu|
      @user_entry.each do |u|
        if cu.room_id == u.room_id
          @is_room = true
          @room_id = cu.room_id
        end
      end
    end
    return if @is_room

    @room = Room.new
    @entry = Entry.new
  end
end
