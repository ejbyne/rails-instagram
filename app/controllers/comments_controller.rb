class CommentsController < ApplicationController

  def create
    if current_user == nil
      flash[:notice] = "You must be logged in to leave a comment"
      redirect_to new_user_session_path
    else
      @picture = Picture.find(params[:picture_id])
      @comment = @picture.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        flash[:notice] = "Comment successfully created"
        redirect_to picture_path(@picture)
      else
        render 'pictures/show'
      end
  end

  def comment_params
    params.require(:comment).permit(:thoughts)
  end

end
