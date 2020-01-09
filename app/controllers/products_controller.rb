class ProductsController < ApplicationController

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :purchase_confirmation, :purchase_done, :pay, :edit, :update, :destroy]
  before_action :set_category, only: [:index, :show, :new]
  before_action :set_delivery_info, only: [:purchase_confirmation, :purchase_done]

  # toppage
  def index
  end

  # 商品詳細
  def show 
    @images = @product.images.order(id: "DESC")
    @image = @product.images.order(id: "DESC").first
  end

  # 商品購入
  def purchase_confirmation
    @image = @product.images.order(id: "DESC").first
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
    @image = @product.images.order(id: "DESC").first
    card = CreditCard.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end
  
  # 商品出品
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render new_product_path unless @product.valid?
    end
  end

  # 商品編集
  def edit
  end

  def update
    if params[:product][:images_attributes] == nil
      @product.update(product_update_params)
      redirect_to action: 'show'
    else
      @product.images.destroy_all
      if @product.update(product_params)
        redirect_to action: 'show'
      else
        redirect_to(edit_product_path, notice: '編集できませんでした')
      end
    end
  end

  # 商品削除
  def destroy
    @product.destroy if @product.user_id == current_user.id
    redirect_to controller: :products, action: :index
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

  # 商品編集用
  def product_update_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :goods_status_id,
      :delivery_charge_id,
      :delivery_way_id,
      :from_prefecture_id,
      :delivery_days_id,
      :price
      ).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
  def set_category
    @parents = Category.all.order(id: "ASC").limit(13)
  end
  
  def set_delivery_info
    @delivery_info = DeliveryInfo.find_by(user_id: current_user.id)
  end
end
