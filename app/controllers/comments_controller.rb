class CommentsController < ApplicationController

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.new(comment_params)
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
