class ClashRequestsController < ApplicationController
  

  def show
    @clash_request = ClashRequest.find(params[:id])
    authorize @clash_request
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
    @clash_request.user = current_user
    @clash_request.user.save!
    redirect_to clash_request_path if @clash_request.save!
  end

  def destroy
  	
  end


  private

  def clash_request_params
    params.require(:clash_request).permit(:status, :user, :publication, :content)
  end
end
