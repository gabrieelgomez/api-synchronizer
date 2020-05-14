# frozen_string_literal: true

# Getter class for obtain each value one item to product instance
class Product::Getter
  attr_reader :item, :product
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
    @product = Product.find_or_initialize_by(external_id: @item['id'])
    @product.attributes = @item.except(*KEYS_EXCEPTIONS)
    @product.store      = @store

    # TODO: remove this assignement when from api return correct format values
    @product.date_created      = parse_date(@item['date_created'])
    @product.date_modified     = parse_date(@item['date_modified'])
    @product.date_on_sale_from = parse_date(@item['date_on_sale_from'])
    @product.date_on_sale_to   = parse_date(@item['date_on_sale_to'])
    @product.price             = @item['price']
    @product.regular_price     = @item['regular_price']
    @product.sale_price        = @item['price']
    @product.sku               = @product.external_id
  end

  def set_classification
    result = []
    Classification::TYPES.map do |classification|
      # TODO: remove JSON.parse when from API return correct hash format
      subcategories = JSON.parse(@item[classification])
      result += Subcategory.build_in_batch(subcategories, classification)
    end
    @product.subcategory_ids = result.pluck(:id).uniq.compact
  end

  def set_variations
    # TODO: remove JSON.parse when from API return correct hash format
    # TODO: refactor variations when exists data from woocommerce
    # variations = JSON.parse(@item['variations])
    @product.variations = @item['variations']
  end
end
