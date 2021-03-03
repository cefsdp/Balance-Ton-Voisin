class UsersController < ApplicationController
  def show
    @disable_nav = true
  	@user = User.find(params[:id])
    authorize @user
    @user.ranking
    @publications = policy_scope(Publication).where(user: @user)
    @comments = policy_scope(Comment).where(user: @user)
    @clash_requests = policy_scope(ClashRequest).where(user: @user).where(status: "confirmed")
    @clashs = []
    @clash_requests.each do |request|
      if request.user == @user
        @clashs << policy_scope(Clash).where(clash_request_id: request)
      end
    end
    @clashcount = []
    @clashs.each do |clash|
      @clashcount << clash
    end
    @publications.each do |publication|
      if publication.clash_requests != []
        publication.clash_requests.each do |request|
          if (@clashunit = Clash.all.where(clash_request_id: request)).exists?
            @clashcount << @clashunit
          end
        end
      end
    end
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
