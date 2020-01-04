class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.text :description
      t.references :category, null: false
      t.references :brand
      t.integer :goods_status_id, null: false
      t.integer :delivery_charge_id, null: false
      t.integer :delivery_way_id, null: false
      t.integer :from_prefecture_id, null: false
      t.integer :delivery_days_id, null: false
      t.integer :price, null: false
      t.integer :selling_status_id, null: false, default: 1
      t.timestamps
    end
  end
end
