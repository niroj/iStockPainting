class PaintingsController < ApplicationController
  def index
    @painting = Painting.all
  end
  def new
    @painting = current_user.paintings.new
  end
  def create
    @painting = current_user.paintings.new(params[:painting])
    if @painting.save
      flash[:notice] = "Successfully uploaded painting."
      redirect_to @painting, :action => 'index'
    else
      render :action => 'index'
    end
  end
  def show
    @painting = Painting.find(params[:id])
  end
end
