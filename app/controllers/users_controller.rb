class UsersController < ApplicationController
  before_action :authenticate_user!

  PER = 10

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(PER)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.includes(:taggings)
    @following = @user.following
    @followers = @user.followers
    @liked_posts = @user.liked_posts.includes(:taggings, [:user])
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
