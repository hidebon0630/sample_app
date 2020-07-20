class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    return unless Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?

    @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
    return unless @message.save

    @message = Message.new
    @room = Room.find(params[:message][:room_id])
    @messages = @room.messages
    @entries = @room.entries
    respond_to do |format|
      format.js
    end
  end
end
