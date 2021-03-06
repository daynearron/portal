class FlyersController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    if params[:category].blank?
      @flyers = Flyer.all.order("created_at DESC")
    else
      @category = Category.find_by(name: params[:category])
      if @category.root?
        # Parent category
        subcategory_ids = @category.children.pluck(:id)
        @flyers = Flyer.joins("LEFT JOIN flyers_subcategories ON flyers_subcategories.flyer_id = flyers.id").where("flyers.category_id = ? or flyers_subcategories.category_id IN (?)", @category.id, subcategory_ids).order("created_at DESC")
      else
        # Subcategory
        @flyers = Flyer.joins(:flyers_subcategories).where("flyers_subcategories.category_id = ?", @category.id).order("created_at DESC")
      end
    end
  end

  def recent
    @flyers = Flyer.where("created_at > ?", Time.current - 20.days)
    render :index
  end

  def show

  end

  def new
    @flyer = current_user.flyers.build
  end

  def create
    @flyer = current_user.flyers.build(post_params) 
    if  @flyer.save
      redirect_to flyers_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @flyer.update(post_params)
      redirect_to flyers_path
    else
      render 'edit'
    end
  end

  def destroy
    @flyer.destroy
    redirect_to flyers_path
  end

  private


  def post_params
    params.require(:flyer).permit(:title, :description, :document, :category_id, flyers_subcategories_attributes: [:id, :category_id, :_destroy])
  end

  def find_post
    @flyer = Flyer.find(params[:id])
  end
end
