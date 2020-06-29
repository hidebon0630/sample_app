class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[following followers]
  def index
    @users = User.page(params[:page]).per(30)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page])
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

  def following
    @title = 'フォロー'
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
end
