class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :email, :address, :notes, :balance
end
