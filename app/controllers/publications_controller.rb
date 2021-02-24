class PublicationsController < ApplicationController
  def index
    @publications = policy_scope(Publication)
  end

  def show
    @publication = Publication.find(params[:id])
    authorize @publication
    @comments = Comment.where(publication_id: @publication)
    @comment = Comment.new
  end

  def new
    @publication = Publication.new
    authorize @publication
  end

  def create
    @publication = Publication.new(publication_params)
    authorize @publication
    @publication.user = current_user
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
    @publication.destroy
    redirect_to publications_path
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :user, :content)
  end
end
