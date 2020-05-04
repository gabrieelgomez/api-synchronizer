# frozen_string_literal: true

# Getter class for obtain each value one item to product instance
class Product::Getter
  attr_reader :item, :product
  KEYS_EXCEPTIONS = %w[id dimensions categories brands genders disciplines
                       variations tags images attributes
                       default_attributes links].freeze

  def initialize(item)
    @item = item
    find_or_initialize_object
    # set_categorization, categories, brands, genders, disciples
    # set_variations
    # set_tags
    # set_images
    # set_attributes
    # set_default_attributes
    # set_links
  end

  private

  def find_or_initialize_object
    @product = Product.find_or_initialize_by(external_id: @item['external_id'])
    @product.attributes = item.except(*KEYS_EXCEPTIONS)
  end
end
