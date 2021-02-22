class PublicationsController < ApplicationController
  def index
    @publications = Publication.all
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    @publication.save
    redirect_to publications_index_path
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    @publication.update(publication_params)
    redirect_to publications_path
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy
    redirect_to publications_path
  end

  def publication_params
    params.require(:publication).permit(:title, :user)
  end
end
