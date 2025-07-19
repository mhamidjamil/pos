class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :location, :fulfilled

  belongs_to :product
end
