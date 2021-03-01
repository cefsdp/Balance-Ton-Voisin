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
    redirect_to publication_path(@publication) if @clash_request.save! 
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
end
