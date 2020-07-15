class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user!

  def create
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.js
    end
  end

  private

    def set_user!
      @user = User.find(params[:user_id])
    end
end
