class PaintingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  def index
    @categories = Category.all
    @paintings = Painting.where(:status => true)
  end
  def new
    @categories = Category.all
    @painting = current_user.paintings.new
  end

  def create
    @painting = current_user.paintings.new(params[:painting])
    @painting.category_id = params[:category][:id]
    if @painting.save
      flash[:notice] = "Successfully uploaded painting."
      redirect_to @painting, :action => 'index'
    else
      render :action => 'index'
    end
  end

  def show
    @categories = Category.all
    if params[:id].nil?
      @painting = Painting.where(:id => 8).last
    else
      @painting = Painting.find(params[:id])
    end
  end

  def buy
    @painting = Painting.find(params[:id])
    app_earning = @painting.credits*0.05
    if(current_user.credits >= (@painting.credits+app_earning))
      current_user.credits -= (@painting.credits+app_earning)
      seller = User.where(:id => @painting.user_id).last
      seller.credits += (@painting.credits-app_earning)
      @painting.status = false
      @painting.save
      current_user.save
      seller.save
    end
  end

end
