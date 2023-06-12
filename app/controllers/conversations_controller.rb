class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    other_user = @conversation.other_user(current_user)
    unless current_user.mutual_follow?(other_user)
      redirect_to user_path(other_user)
      return
    end
    @message = Message.new
  end

  def create
    @user = User.find(params[:user_id])
    conversation = current_user.find_or_create_conversation_with(@user)
    if conversation.save!
      redirect_to conversation_path(conversation)
    else
      redirect_to user_path(user), status: :unprocessable_entity
    end
  end

end
