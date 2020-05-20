# frozen_string_literal: true

# Setter class for get a product instance
class Product::Setter
  # Loop for each products from one store api
  def self.sync_products_from_api(items, store)
    items.each { |product| set(product, store) }
  end

  # Set one product for get all properties
  def self.set(product, store)
    product = Product::Getter.new(product, store).product
    return product if product.save
  end
end
