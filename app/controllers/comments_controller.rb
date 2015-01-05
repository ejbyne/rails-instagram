class CommentsController < ApplicationController

  def create
    @picture = Picture.find(params[:picture_id])
    @picture.comments.create(comment_params)
    flash[:notice] = "Comment successfully created"
    redirect_to picture_path(@picture)
  end

  def comment_params
    params.require(:comment).permit(:thoughts)
  end

end
