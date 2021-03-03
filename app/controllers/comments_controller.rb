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
    @comment.user.ranking
    @comment.user.save!
    notification_builder
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
    comment_destroy
    @comment.user.score -= 2
    @comment.user.ranking
    redirect_to publication_path(@comment.publication)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user, :publication)
  end

  def comment_destroy
    authorize @comment
    @comment.user.save!
    @comment.destroy
  end

  def notification_builder
    @notification = Notification.create(notification_type: "comment", user_id: @publication.user_id, params: { data: @comment })
    notificationcable
  end

  def notificationcable
    NotificationChannel.broadcast_to(
      @publication.user,
      txt: `Vous avez un nouveau commentaire de #{@comment.user}`
    )
  end
end
