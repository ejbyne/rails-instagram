class CommentsController < ApplicationController

  def create
    if current_user == nil
      flash[:danger] = "You must be logged in to leave a comment"
      redirect_to new_user_session_path
    else
      @picture = Picture.find(params[:picture_id])
      @comment = @picture.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        flash[:success] = "Comment successfully created"
        redirect_to picture_path(@picture)
      else
        render 'pictures/show'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @picture = Picture.find(@comment.picture_id)
    if current_user == nil || current_user.id != @comment.user_id
      flash[:danger] = "You cannot delete a comment you haven't posted"
      redirect_to picture_path(@picture)
    else
      @comment.destroy
      flash[:success] = 'Comment deleted successfully'
      redirect_to picture_path(@picture)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment)
    end

end
