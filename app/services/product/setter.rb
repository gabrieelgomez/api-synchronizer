# frozen_string_literal: true

# Setter class for get a product instance
class Product::Setter
  def self.set(product)
    new(product).perform
  end

  def initialize(product)
    @getter = Product::Getter.new(product)
  end

  def perform
    product
    # return product if product.save
  end

  private

  def product
    @product ||= @getter.product
  end
end
