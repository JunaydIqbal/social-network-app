class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_login, only: [:index]

  def create
    
    #Friendship.create(friendship_params)
    current_user.friendships.create!(friendship_params)
    redirect_to friendships_path
  end

  def destroy
    another_user = User.find(params[:user_id])
    current_user.friends.delete(another_user)
    redirect_to friendships_path
  end

  private

    def friendship_params
      params.require(:friendship).permit(:friend_id)
    end

end
