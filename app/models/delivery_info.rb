class DeliveryInfo < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  VALID_POSTAL_CODE = /\A\d{3}-\d{4}\z/i
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  # STEP5
  validates :l_name, presence: true, length: { maximum: 35 }
  validates :f_name, presence: true, length: { maximum: 35 }
  validates :l_name_kana, presence: true, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}
  validates :f_name_kana, presence: true, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}
  validates :postal_code, presence: true, length: { maximum: 8 }, format: { with: VALID_POSTAL_CODE, message: 'のフォーマットが不適切です' }
  validates :prefecture_id, presence: { message: 'を選択してください'}, numericality: { only_integer: true, less_than: 49 }
  validates :city, presence: true, length: { maximum: 50 }
  validates :block_number, presence: true, length: { maximum: 100 }

end
