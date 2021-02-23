class CommentsController < ApplicationController
  def index
    @comments = policy_scope(Comment)
  end

  def new
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @publication = Publication.find(params[:publication_id])
    authorize @comment
    @comment.user = current_user
    @comment.publication = @publication
    redirect_to publication_path(@publication) if @comment.save!
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(comment_params)
    redirect_to publications_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to publications_path
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :user, :publication)
  end

end
