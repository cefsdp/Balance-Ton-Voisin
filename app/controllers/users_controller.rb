class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    authorize @user
    @publications = policy_scope(Publication).where(user: @user)
    @comments = policy_scope(Comment).where(user: @user)
  end
end