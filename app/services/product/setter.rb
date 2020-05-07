# frozen_string_literal: true

# Setter class for get a product instance
class Product::Setter
  def self.set(product, store)
    new(product, store).perform
  end

  def initialize(product, store)
    @getter = Product::Getter.new(product, store)
  end

  def perform
    return product if product.save
  end

  private

  def product
    @product ||= @getter.product
  end
end
