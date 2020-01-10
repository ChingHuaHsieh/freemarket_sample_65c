class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :delivery_way
  belongs_to_active_hash :from_prefecture
  belongs_to_active_hash :goods_status
  belongs_to_active_hash :selling_status

  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many   :images,dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: { message: 'を選択してください'}
  validates :goods_status_id, presence: { message: 'を選択してください'}
  validates :delivery_charge_id, presence: { message: 'を選択してください'}
  validates :delivery_way_id, presence: { message: 'を選択してください'}
  validates :from_prefecture_id, presence: { message: 'を選択してください'}
  validates :delivery_days_id, presence: { message: 'を選択してください'}
  validates :price, presence: true, inclusion: 300..9999999
end
