# frozen_string_literal: true

# Product module of Product model
module Product
  # Parse class for loop each store
  class Parse
    def proccess(store)
      store.products.each do |product|
        next unless product.is_a?(Hash)

        Product::Setter.set(product)
      end
    end
  end
end
