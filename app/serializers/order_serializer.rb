class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :notes, :created_at, :updated_at

  belongs_to :customer
  has_many :order_items
end
