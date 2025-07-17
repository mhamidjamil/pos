class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :purchase_price
      t.decimal :sale_price
      t.string :product_code
      t.integer :quantity_in_stock
      t.integer :carton_quantity
      t.string :unit_label
      t.string :tags
      t.string :status, default: 'active'
      t.string :category
      t.string :brand

      t.timestamps
    end
  end
end
