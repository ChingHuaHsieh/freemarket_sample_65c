class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def purchase_confirmation
  end
  
  def new
    @product = Product.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path unless @product.valid?
    end
  end

  def show
    @parents = Category.all.order("id ASC").limit(13)
    @images = @product.images
    @image = @images.first
  end

  private
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :goods_status_id,
      :delivery_charge_id,
      :delivery_way_id,
      :from_prefecture_id,
      :delivery_days_id,
      :price,
      images_attributes: [:image]
      ).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
