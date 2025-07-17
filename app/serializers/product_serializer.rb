class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :purchase_price, :sale_price, :product_code,
             :quantity_in_stock, :carton_quantity, :unit_label, :tags
end
