class RelationshipsController < ApplicationController

  def index
    if params[:follower_toggle].present?
      @relationships = Relationship.where(
        leader_id: current_user.id,
        # leader_id: params[:leader_id]
      )
    else
      @relationships = Relationship.where(
        follower_id: current_user.id,
        # leader_id: params[:leader_id]
      )
    end
    render :index
  end

  def show
    @relationship = Relationship.where(
      follower_id: current_user.id,
      leader_id: params[:leader_id]
    )
  end

  def create
    @relationship = Relationship.new(
      follower_id: current_user.id,
      leader_id: params[:leader_id]
    )
    if @relationship.save
      render json: {message: "youre following someone new"}
    else
      render json: {message: "there was a problem"}
    end
  end

  def destroy
    user = Relationship.find(params[:id]).leader
    current_user.unfollow(user)
    render json: {message: "you unfollowed someone"}
  end

end
