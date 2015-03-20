class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    if current_user
      @picture = Picture.new
    else
      flash[:notice] = "You must be logged in to add a picture"
      redirect_to new_user_session_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      flash[:notice] = "Picture successfully created"
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
      flash[:notice] = "You cannot delete a picture you haven't posted"
      redirect_to picture_path(@picture)
    else
      @picture.destroy
      flash[:notice] = 'Picture deleted successfully'
      redirect_to pictures_path
    end
  end

  private

    def picture_params
      params.require(:picture).permit(:name, :image)
    end

end
