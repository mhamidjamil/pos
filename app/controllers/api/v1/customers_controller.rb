# app/controllers/api/v1/customers_controller.rb
module Api
  module V1
    class CustomersController < ApplicationController
      def index
        customers = Customer.all
        render json: customers
      end

      def show
        customer = Customer.find(params[:id])
        render json: customer
      end

      def create
        customer = Customer.new(customer_params)
        if customer.save
          render json: customer, status: :created
        else
          render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        customer = Customer.find(params[:id])
        if customer.update(customer_params)
          render json: customer
        else
          render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        customer = Customer.find(params[:id])
        customer.destroy
        head :no_content
      end

      private

      def customer_params
        params.require(:customer).permit(:name, :phone, :email, :address, :notes, :balance)
      end
    end
  end
end
