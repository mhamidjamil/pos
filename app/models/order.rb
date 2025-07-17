class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items

  enum status: { pending: "pending", completed: "completed", partial: "partial", cancelled: "cancelled" }
  accepts_nested_attributes_for :order_items, allow_destroy: true
end
