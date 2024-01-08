class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:leader_id])
    current_user.follow(user)
    render json: {message: "youre following someone new"}
  end

  def destroy
    user = Relationship.find(params[:id]).leader
    current_user.unfollow(user)
    render json: {message: "you unfollowed someone"}
  end

end
