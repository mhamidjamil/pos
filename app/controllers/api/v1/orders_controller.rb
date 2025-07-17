# app/controllers/api/v1/orders_controller.rb
module Api
  module V1
    class OrdersController < ApplicationController
      def index
        orders = Order.includes(:customer, :order_items).all
        render json: orders
      end

      def show
        order = Order.includes(:customer, :order_items).find(params[:id])
        render json: order
      end

      def create
        order = Order.new(order_params)

        if order.save
          render json: order, status: :created
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        order = Order.find(params[:id])

        if order.update(order_params)
          render json: order
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        order = Order.find(params[:id])
        order.destroy
        head :no_content
      end

      private

      def order_params
        params.require(:order).permit(
          :customer_id, :status, :notes,
          order_items_attributes: [
            :id, :product_id, :quantity, :location, :fulfilled, :_destroy
          ]
        )
      end
    end
  end
end
