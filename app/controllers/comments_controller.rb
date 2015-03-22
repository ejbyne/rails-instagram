class CommentsController < ApplicationController

  def create
    if !user_signed_in?
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
        @previous_picture = @picture.previous
        @next_picture = @picture.next
        render 'pictures/show'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @picture = Picture.find(@comment.picture_id)
    if !user_signed_in? || current_user.id != @comment.user_id
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
