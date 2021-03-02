class ClashRequestsController < ApplicationController
  def index
    @clash_requests = policy_scope(ClashRequests)
  end

  def new
    @publication = Publication.find(params[:publication_id]) 	
    @clash_request = ClashRequest.new
    authorize @clash_request
  end

  def create
    @clash_request = ClashRequest.new(clash_request_params)
    authorize @clash_request
    @publication = Publication.find(params[:publication_id])
    @clash_request.publication = @publication
    @clash_request.user = current_user
    if @clash_request.save!
      build_notif
      notificationcable
      redirect_to publication_path(@publication)
    end
  end

  def edit
    @clash_request = ClashRequest.find(params[:id])
    authorize @clash_request
  end

  def update
    @clash_request = ClashRequest.find(params[:id])
    authorize @clash_request
    @clash_request.update(clash_request_params)
    redirect_to publication_path(@clash_request.publication)
  end

  def destroy
    @clash_request = ClashRequest.find(params[:id])
    authorize @clash_request
    @clash_request.destroy
    redirect_to publication_path(@clash_request.publication)
  end

  private

  def clash_request_params
    params.require(:clash_request).permit(:status, :user, :publication, :content)
  end

  def build_notif
    @notification = Notification.create(notification_type: "clashrequest", user_id: @publication.user_id, params: { data: @clash_request })
    notificationcable
  end

  def notificationcable
    NotificationChannel.broadcast_to(
      @publication.user,
      txt: `Vous avez une demande de clash par #{@clash_request.user}`
    )
  end
end
