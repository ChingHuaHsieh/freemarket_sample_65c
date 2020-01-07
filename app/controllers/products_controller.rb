class ProductsController < ApplicationController

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  before_action :set_product, only: [:show, :purchase_confirmation, :purchase_done, :pay]
  before_action :set_category, only: [:index, :show, :new]
  before_action :set_delivery_info, only: [:purchase_confirmation, :purchase_done]

  def index
  end

  def show
    @images = @product.images
    @image = @images.first
  end

  def purchase_confirmation
    @image = @product.images.first
    card = CreditCard.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: '/signup/credit_card'
    else
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = CreditCard.find_by(user_id: current_user.id)
    Payjp::Charge.create(
    amount: @product.price, #支払金額を入力
    customer: card.customer_id, #顧客ID
    currency: 'jpy', #日本円
    )
    @product.update(selling_status_id: 4)
    redirect_to action: 'purchase_done' #完了画面に移動
  end

  def purchase_done
    @image = @product.images.first
    card = CreditCard.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path unless @product.valid?
    end
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
  
  def set_category
    @parents = Category.all.order("id ASC").limit(13)
  end

  
  def set_delivery_info
    @delivery_info = DeliveryInfo.find_by(user_id: current_user.id)
  end
end
