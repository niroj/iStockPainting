class PaintingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  def index
    @paintings = Painting.where(:status => true)
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
    if params[:id].nil?
      @painting = Painting.where(:id => 8).last
    else
      @painting = Painting.find(params[:id])
    end
  end
  
  def buy
    @painting = Painting.find(params[:id])
    if(current_user.credits >= @painting.credits)
      current_user.credits -= @painting.credits
      seller = User.where(:id => @painting.user_id).last
      seller.credits += @painting.credits
      @painting.status = false
      @painting.save
      current_user.save
      seller.save
    end
  end
  
end
