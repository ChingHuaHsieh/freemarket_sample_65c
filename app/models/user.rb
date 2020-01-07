class User < ApplicationRecord
  include ActionView::Helpers::ApplicationHelper
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_yyyy
  belongs_to_active_hash :birth_mm
  belongs_to_active_hash :birth_dd

  has_many :products
  has_many :credit_cards
  has_one :delivery_info
end
