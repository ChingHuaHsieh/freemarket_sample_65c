class User < ApplicationRecord

  include ActionView::Helpers::ApplicationHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_yyyy
  belongs_to_active_hash :birth_mm
  belongs_to_active_hash :birth_dd

  has_many :products
  has_many :comments
  has_many :credit_cards
  has_one :delivery_info

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d!@#\$%\^\&*\)\(+=._-]{7,128}\z/i

  # STEP2 user_info
  validates :nickname, presence: true, length: { maximum: 20, message: 'を20文字以内にしてください' }, profanity_filter: true
  validates :email, presence: true, uniqueness: { message: 'はすでに使用されている'}, format: { with: VALID_EMAIL_REGEX, message: 'のフォーマットが不適切です'}
  validates :password, presence: true, length: { in: 7..128, message: 'を7桁以上にしてください' }, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字両方を含むパスワードを設定してください'}
  validates :password_confirmation, presence: true, length: { in: 7..128, message: 'を7桁以上にしてください' }, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字両方を含むパスワードを設定してください'}
  validates :l_name, presence: true, length: { maximum: 35, message: 'を35文字以内にしてください' }, profanity_filter: true
  validates :f_name, presence: true, length: { maximum: 35, message: 'を35文字以内にしてください' }, profanity_filter: true
  validates :l_name_kana, presence: true, length: { maximum: 35, message: 'を35文字以内にしてください' }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}, profanity_filter: true
  validates :f_name_kana, presence: true, length: { maximum: 35, message: 'を35文字以内にしてください' }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}, profanity_filter: true
  validates :birth_yyyy_id, presence: { message: 'を選択してください'}
  validates :birth_mm_id, presence: { message: 'を選択してください'}
  validates :birth_dd_id, presence: { message: 'を選択してください'}

  # STEP3
  validates :phone_num, presence: true, format: { with: /\A\d{10,11}\z/, message: 'の入力が正しくありません'}

  # STEP4
  validates :authentication_num, presence: true, length: { is: 4, message: 'を4文字以内にしてください' }, numericality: { only_integer: true }


end
