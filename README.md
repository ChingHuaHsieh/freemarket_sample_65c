## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|f_name_kanji|string|null: false|
|l_name_kanji|string|null: false|
|f_name_kana|string|null: false|
|l_name_kana|string|null: false|
|birthday|integer|null: false|
|phone_num|integer|null: false|
|authentication_num|integer|null: false|
|description|text||

### Association
- has_many :products
- has_many :comments
- han_one :credit_card
- has_one :delivery_info

## delivery_infosテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false,foreign_key: true|
|f_name_kanji|string|null: false|
|l_name_kanji|string|null: false|
|f_name_kana|string|null: false|
|l_name_kana|string|null: false|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|building_name|string||
|telephone|string||

### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false,foreign_key: true|
|name|string|null: false|
|content|text|null: false|
|category|integer|null: false|
|goods_status|integer|null: false|
|delivery_charge|integer|null: false|
|delivery_way|integer|null: false|
|from_prefecture|integer|null: false|
|delivery_days|integer|null: false|
|price|integer|null: false|
|brand|references||
|selling_status|integer|null: false|


### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- has_many_attached :images
- has_many :comments

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false,foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|integer||

### Association
- has_many :products

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false,foreign_key: true|
|product|references|null: false,foreign_key: true||
|text|text|null: false|

### Association
- belongs_to :user
- belongs_to :product

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

### Association
- has_many :products

hello world
