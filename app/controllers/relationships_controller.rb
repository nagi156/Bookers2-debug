class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to request.referer
  end
  
  # フォローしているユーザー一覧の表示のアクション
  def followings
    user = User.find(params[:id])
    @user = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.followers
  end
end
