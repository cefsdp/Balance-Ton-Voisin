class UsersController < ApplicationController
  def show
    @disable_nav = true
  	@user = User.find(params[:id])
    @user.ranking
    authorize @user
    @publications = policy_scope(Publication).where(user: @user)
    @comments = policy_scope(Comment).where(user: @user)
    @disable_nav = true
  end
end
