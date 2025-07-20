module Api
  module V1
    class ProductsController < ApplicationController
      def index
        products = Product.all
        render json: products
      end

      def show
        product = Product.find(params[:id])
        render json: product
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: product, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: product
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.destroy
        head :no_content
      end

    def import
      if params[:file].blank?
        return render json: { error: "No file provided" }, status: :bad_request
      end

      file = params[:file]

      begin
        spreadsheet = Roo::Spreadsheet.open(file.path)
        spreadsheet.default_sheet = spreadsheet.sheets.first

        header_row = 1
        header = spreadsheet.row(header_row).map(&:to_s)

        created_count = 0
        updated_count = 0
        failed_rows = []

        (header_row + 1).upto(spreadsheet.last_row) do |i|
          row_data = Hash[[ header, spreadsheet.row(i) ].transpose]

          begin
            product = Product.find_or_initialize_by(product_code: row_data["Code"])

            product.name              = row_data["NAME"] || "temp"
            product.description       = row_data["Description"] || ""
            product.sale_price        = row_data["COST"].to_f rescue 0
            product.quantity_in_stock = row_data["PCS/CTN"].to_i rescue 0
            product.unit_label        = row_data["Unit Label"] || "piece"

            if product.new_record?
              product.save!
              created_count += 1
            elsif product.changed?
              debugger
              product.save!
              updated_count += 1
            end

          rescue => e
            failed_rows << {
              row_number: i,
              data: row_data,
              error: e.message
            }
          end
        end

        render json: {
          message: "Product import completed.",
          created: created_count,
          updated: updated_count,
          failed: failed_rows.size,
          errors: failed_rows
        }, status: :ok

      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

      private

      def product_params
        params.require(:product).permit(:name, :description, :purchase_price, :sale_price,
          :product_code, :quantity_in_stock, :carton_quantity, :unit_label, tags: [])
      end
    end
  end
end
