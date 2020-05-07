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
      @woocommerce.post('products/batch', @batch_json).parsed_response
    end

    private

    def set_api
      @products_woo = @woocommerce.get('products').parsed_response
    end
  end
end
