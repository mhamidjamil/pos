class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.text :notes
      t.decimal :total_amount, precision: 10, scale: 2
      t.decimal :paid_amount, precision: 10, scale: 2, default: 0.0
      t.decimal :due_amount, precision: 10, scale: 2, default: 0.0
      t.datetime :order_date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
