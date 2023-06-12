class MessagesController < ApplicationController
  before_action :set_conversation, only: :create

  def create
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @conversation
    else
      flash.now[:alert] = @message.errors.full_messages.join(', ')
      redirect_to @conversation, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end
end
