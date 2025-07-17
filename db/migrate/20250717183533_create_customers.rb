class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :address
      t.text :notes
      t.integer :balance, default: 0
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
