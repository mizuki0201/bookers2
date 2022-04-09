class RelationshipsController < ApplicationController
  def create
    friend = current_user.relationships.new(followed_id: params[:user_id])
    friend.save
    redirect_to users_path
  end

  def destroy
    Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id]).destroy
    redirect_to users_path
  end
end
