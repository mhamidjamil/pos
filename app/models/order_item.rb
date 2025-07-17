class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  enum location: { store: "store", warehouse: "warehouse", both: "both" }

  validates :quantity, presence: true
end
