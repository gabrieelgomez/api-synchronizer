# frozen_string_literal: true

# WooCommerce module
module WooCommerce
  # API class extended
  class Batch
    def initialize(url = nil, key = nil, secret = nil, args = {})
      woocommerce = WooCommerce::API.new(
        url,
        key,
        secret,
        args
      )
      @woocommerce = woocommerce
    end

    def build_in_batch(products_rails)
      set_api

      # separate which products will be to create and which
      # to update from woocommerce products
      result = Product.define_create_and_update(products_rails, @products_woo)

      # build the correct woocommerce batch format
      @batch_json = Product.build_json(result[:to_create], result[:to_update])

      # Send data to create and update to woocommerce
      res_woo = @woocommerce.post('products/batch', @batch_json).parsed_response

      res_woo['create'] ||= []
      res_woo['update'] ||= []

      products = (res_woo['create'] + res_woo['update']).flatten
      create_and_update_variation(products)
    end

    private

    def create_and_update_variation(products)
      products.map do |product|
        product_rails = Product.find_by(sku: product['sku'])
        product_rails.update(woocommerce_id: product['id'])
        product_rails.build_json_variations.each do |variation|
          product_woocommerce = product['id']
          res = @woocommerce.get("products/#{product_woocommerce}/variations",
                                 { sku: variation[:sku] }).parsed_response
          if res.any?
            # Update variation
            id = res.first['id']
            @woocommerce.put("products/#{product_woocommerce}/variations/#{id}",
                             variation).parsed_response
            next
          else
            # Create variation
            @woocommerce.post("products/#{product_woocommerce}/variations",
                              variation).parsed_response
          end
        end
      end
    end

    def set_api
      @products_woo = @woocommerce.get('products').parsed_response
    end
  end
end
