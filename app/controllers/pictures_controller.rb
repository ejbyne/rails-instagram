class PicturesController < ApplicationController
  
  before_filter :page_params, :only => :index

  def index
    @pictures = Picture.order(created_at: :desc).paginate(page: params[:page], :per_page => 12)
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
    @previous_picture = @picture.previous
    @next_picture = @picture.next
    @comment = Comment.new
  end

  def destroy
    @picture = Picture.find(params[:id])
    if !user_signed_in? || current_user.id != @picture.user_id
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
      params.require(:picture).permit(:image) if params[:picture]
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end

    def page_key
      (self.class.to_s + "_page").to_sym
    end

    def page_params
      if params[:page]
        session[page_key] = params[:page]
      elsif session[page_key]
        params[:page] = session[page_key]
      end
    end

end
