class DeliveryInfosController < ApplicationController

  def new
    @delivery_info = DeliveryInfo.new
  end

  def create
    @delivery_info = DeliveryInfo.new(delivery_info_params)
    if @delivery_info.save
      redirect_to credit_card_signup_index_path
    else
      redirect_to '/delivery_infos/new' unless @delivery_info.valid?
    end
  end
  
  private
  def delivery_info_params
    params.require(:delivery_info).permit(
      :user_id,
      :l_name,
      :f_name,
      :l_name_kana,
      :f_name_kana,
      :postal_code,
      :prefecture_id,
      :city,
      :block_number,
      :building_name,
      :telephone,
    ).merge(user_id: session[:id])
  end
end
