class PicturesController < ApplicationController

  def index
    @pictures = current_user.pictures
  end

  def new
    @user = current_user
    @picture = Picture.new
  end

  def create
    @user = current_user

    @user.pictures.create(picture_params)

    redirect_to user_pictures_path
  end

  private

  def picture_params
    params.require(:picture).permit(:picture)
  end

end
