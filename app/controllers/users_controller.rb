class UsersController < ApplicationController
  def show
    @disable_nav = true
  	@user = User.find(params[:id])
    authorize @user
    @publications = policy_scope(Publication).where(user: @user)
    @comments = policy_scope(Comment).where(user: @user)
    check_notif_read
    @disable_nav = true
  end

  private

  def check_notif_read
    current_user.notifications.each do |notification|
      notification.destroy if notification.notification_type == "ranking"
    end
  end
end
