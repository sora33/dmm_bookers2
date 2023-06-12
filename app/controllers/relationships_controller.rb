class RelationshipsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def create
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
