class CreateDeliveryInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_infos do |t|
      t.references :user,       null: false,foreign_key: true
      t.string :l_name,         null: false
      t.string :f_name,         null: false
      t.string :l_name_kana,    null: false
      t.string :f_name_kana,    null: false
      t.string :postal_code,    null: false
      t.integer :prefecture_id,    null: false
      t.string :city,           null: false
      t.string :block_number,   null: false
      t.string :building_name
      t.string :telephone
      t.timestamps
    end
  end
end
