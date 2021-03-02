class ClashesController < ApplicationController

  def index
  	@clash = policy_scope(Clash)
  end

  def create
  	@clash = Clash.new
    @clash_request = ClashRequest.find(params[:clash_request_id])
  	@publication = @clash_request.publication
    @clash.clash_request = @clash_request
    @clash.publisher_votes = 0
    @clash.contender_votes = 0
    @clash.countdown_end = DateTime.now + 1.day
    authorize @clash
    redirect_to publication_path(@publication) if @clash.save!
  end

end
