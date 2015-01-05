class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(picture_params)
    flash[:notice] = "Picture successfully created"
    redirect_to picture_path(@picture)
  end

  def show
    @picture = Picture.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.update(picture_params)
    redirect_to pictures_path
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:notice] = 'Picture deleted successfully'
    redirect_to pictures_path
  end

  private

    def picture_params
      params.require(:picture).permit(:name)
    end

end
