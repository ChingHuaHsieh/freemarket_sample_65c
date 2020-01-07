class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_yyyy
  belongs_to_active_hash :birth_mm
  belongs_to_active_hash :birth_dd

  has_many :products
  has_many :credit_cards
  has_one :delivery_info

  def full_name
    "#{self.l_name} #{self.f_name}"
  end

  def full_name_kana
    "#{self.l_name_kana} #{self.f_name_kana}"
  end

  def birthday
    "#{BirthYyyy.find(self.birth_yyyy_id).year}/#{BirthMm.find(self.birth_mm_id).month}/#{BirthDd.find(self.birth_dd_id).day}"
  end
end
