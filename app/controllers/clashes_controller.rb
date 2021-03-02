class ClashesController < ApplicationController
  def index
    @clash = policy_scope(Clash)
  end

  def create
    @clash = Clash.new
    @publication = Publication.find(params[:publication_id])
    @clash_request = ClashRequest.find(params[:clash_request_id])
    @clash.clash_request = @clash_request
    @clash.publisher_votes = 0
    @clash.contender_votes = 0
    @clash.countdown_end = DateTime.now + 1.day
    authorize @clash
    redirect_to publication_path(@publication) if @clash.save!
  end

  private

  def notificationcable
    NotificationChannel.broadcast_to(
      @publication.user,
      txt: `Vous avez une demande de clash par #{@comment.user}`
    )
  end
end
