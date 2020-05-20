# frozen_string_literal: true

# Getter class for obtain each value one item to product instance
class Product::Getter
  attr_reader :item, :product, :store
  KEYS_EXCEPTIONS = %w[id dimensions categories brands genders disciplines
                       variations tags images attributes
                       default_attributes links type].freeze

  def initialize(item, store)
    @item = item
    @store = store
    find_or_initialize_object
    set_classification
    set_variations

    # TODO: complete this callbacks when api returns these values
    # set_images
  end

  private

  def find_or_initialize_object
    @product = Product.find_or_initialize_by(sku: @item['sku'])
    @product.attributes = @item.except(*KEYS_EXCEPTIONS)
    @product.store      = @store
  end

  def set_classification
    result = Classification.create_subcategories(@item)
    @product.subcategory_ids = result.uniq
  end

  def set_variations
    @product.variations = @item['variations']
  end
end
