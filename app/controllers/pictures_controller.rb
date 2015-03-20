class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    if current_user
      @picture = Picture.new
      @comment = Comment.new
    else
      flash[:danger] = "You must be logged in to add a picture"
      redirect_to new_user_session_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @comment = Comment.new(comment_params)
    @picture.user_id = current_user.id
    if @picture.save
      if @comment.comment != ""
        @comment.user_id = current_user.id
        @comment.picture_id = @picture.id
        @comment.save
      end
      flash[:success] = "Picture successfully added"
      redirect_to picture_path(@picture)
    else
      render 'pictures/new'
    end
  end

  def show
    @picture = Picture.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @picture = Picture.find(params[:id])
    if current_user == nil || current_user.id != @picture.user_id
      flash[:danger] = "You cannot delete a picture you haven't posted"
      redirect_to picture_path(@picture)
    else
      @picture.destroy
      flash[:success] = 'Picture deleted successfully'
      redirect_to pictures_path
    end
  end

  private

    def picture_params
      params.require(:picture).permit(:name, :image)
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end

end
