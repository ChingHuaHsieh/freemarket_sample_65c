class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.index :name, unique: true
      t.text :content
      t.references :category, null: false
      t.references :brand
      t.integer :goods_status, null: false
      t.integer :delivery_charge, null: false
      t.integer :delivery_way, null: false
      t.integer :from_prefecture, null: false
      t.integer :delivery_days, null: false
      t.integer :selling_status, null: false
      t.timestamps
    end
  end
end
