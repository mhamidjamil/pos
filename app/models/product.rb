class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :quantity_in_stock, presence: true
end
