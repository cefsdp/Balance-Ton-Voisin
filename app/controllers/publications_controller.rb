class PublicationsController < ApplicationController
  def index
    @publications = policy_scope(Publication)
    @publication = Publication.new

  end

  def show
    @publication = Publication.find(params[:id])
    authorize @publication
    @comments = Comment.where(publication_id: @publication)
    @comment = Comment.new
    @clash_requests = ClashRequest.where(publication_id: @publication)
    @clash = Clash.where(clash_request_id: @clash_requests).first
    @vote_for_publisher = Vote.where(user: current_user, clash: @clash, party: "publisher")
    @vote_for_contender = Vote.where(user: current_user, clash: @clash, party: "contender")
    if @clash
      @publisher_counter = @clash.votes.where(party: "publisher").count
      @contender_counter = @clash.votes.where(party: "contender").count
    end
    check_notif_read
  end

  def new
    @publication = Publication.new
    authorize @publication
  end

  def create
    @publication = Publication.new(publication_params)
    authorize @publication
    @publication.user = current_user
    @publication.user.score += 3 if @publication.save!
    @publication.user.ranking
    @publication.user.save!
    redirect_to publications_path if @publication.save!
  end

  def edit
    @publication = Publication.find(params[:id])
    authorize @publication
  end

  def update
    @publication = Publication.find(params[:id])
    authorize @publication
    @publication.update(publication_params)
    redirect_to publications_path
  end

  def destroy
    @publication = Publication.find(params[:id])
    authorize @publication
    @publication.user.score -= 3
    @publication.user.save!
    @publication.destroy
    redirect_to publications_path
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :user, :content)
  end

  def check_notif_read
    current_user.notifications.each do |notification|
      if @publication.id == notification.params['data']['publication_id']
        notification.destroy
      end
    end
  end
end
