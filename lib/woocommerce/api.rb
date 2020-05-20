# frozen_string_literal: true

# Methods extension for woocommerce_api gem
WooCommerce::API.class_eval do
  def categories
    get('products/categories').parsed_response
  end

  def create_category(data)
    post('products/categories', data).parsed_response
  end

  def build_in_batch(products_rails)
    @products_woo = get('products').parsed_response

    # separate which products will be to create and which
    # to update from woocommerce products
    result = Product.define_create_and_update(products_rails, @products_woo)

    # build the correct woocommerce batch format
    @batch_json = Product.build_json(result[:to_create], result[:to_update])

    # Send data to create and update to woocommerce
    res_woo = post('products/batch', @batch_json).parsed_response

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
        res = get("products/#{product_woocommerce}/variations",
                  { sku: variation[:sku] }).parsed_response
        if res.any?
          # Update variation
          id = res.first['id']
          put("products/#{product_woocommerce}/variations/#{id}",
              variation).parsed_response
          next
        else
          # Create variation
          post("products/#{product_woocommerce}/variations",
               variation).parsed_response
        end
      end
    end
  end
end
