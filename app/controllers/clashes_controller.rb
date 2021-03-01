class ClashesController < ApplicationController

  def index
  	@clash = policy_scope(Clash)
  end

  def create
  	@clash = Clash.new(clash_params)
    authorize @clash
    @clash_request = ClashRequest.find(params[:clash_request_id])
    @clash.clash_request = @clash_request
    @clash.countdown_end = DateTime.now + 1.day
    redirect_to publication_path(@publication) if @clash.save! 
  end


  def clash_params
    params.require(:clash).permit(:clash_request, :countdown_end, :contender_votes, :publisher_votes)
  end
end
