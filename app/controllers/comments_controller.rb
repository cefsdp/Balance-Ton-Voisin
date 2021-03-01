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
    @comment.user.score += 2 if @comment.save!
    @comment.user.save!
    notification = CommentNotification.with(comment: @comment)
    notification.deliver(@comment.publication.user)
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
    redirect_to publication_path(@comment.publication)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @publication = @comment.publication
    if @publication.user.notifications.nil? == false
      @publication.user.notifications.each do |notification|
        notification.delete if notification.params[:comment].id == @comment.id
      end
    end
    comment_destroy
    redirect_to publication_path(@comment.publication)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user, :publication)
  end

  def comment_destroy
    authorize @comment
    @comment.user.score -= 2
    @comment.user.save!
    @comment.destroy
  end
end
