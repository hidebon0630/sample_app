class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[following followers]
  require 'happybirthday'

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find_by(id: params[:id])
    @following = @user.following.page(params[:page]).per(10)
    @followers = @user.followers.page(params[:page]).per(10)
    birthday = Happybirthday.born_on(@user.birth_date)
    @birthday = birthday.age.years_old
    @posts = @user.posts.page(params[:page]).per(10)
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
