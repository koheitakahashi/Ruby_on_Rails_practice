class CommentsController < ApplicationController

  def edit
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable
      flash[:notice] = t("errors.messages.Comment_was_successfully_created.")
    else
      redirect_to @comment.commentable
      flash[:notice] = t("errors.messages.Comment_was_failure_created.")
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if created_user?
      if @comment.update(comment_params)
        redirect_to @comment.commentable
        flash[:notice] = t('errors.messages.Comment_was_successfully_updated.')
      else
        render :edit
        flash[:notice] = t('errors.messages.Comment_was_failure_updated.')
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if created_user?
      if @comment.destroy
        redirect_to @comment.commentable
        flash[:notice] = t('errors.messages.Commnet_was_successfully_destroyed.')
      else
        redirect_to @comment.commentable
        flash[:notice] = t('errors.messages.Comment_was_failure_destroyed.')
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :commentable_type, :commentable_id, :user_id)
  end

  def created_user?
    current_user == @comment.user
  end
end
