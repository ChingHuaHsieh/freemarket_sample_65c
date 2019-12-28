class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :delivery_way
  belongs_to_active_hash :from_prefecture
  belongs_to_active_hash :goods_status
  belongs_to_active_hash :selling_status

  belongs_to :category
  has_many_attached :images

end
