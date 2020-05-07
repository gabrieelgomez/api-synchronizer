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
    # set_tags
    # set_images
    # set_attributes
    # set_default_attributes
    # set_links
  end

  private

  def find_or_initialize_object
    @product = Product.find_or_initialize_by(external_id: @item['id'])
    @product.attributes = @item.except(*KEYS_EXCEPTIONS)
    @product.store      = @store

    # TODO: remove this assignement when from api return correct format values
    @product.date_created      = @product.parse_date(@item['date_created'])
    @product.date_modified     = @product.parse_date(@item['date_modified'])
    @product.date_on_sale_from = @product.parse_date(@item['date_on_sale_from'])
    @product.date_on_sale_to   = @product.parse_date(@item['date_on_sale_to'])
    @product.price             = @item['price'].gsub(',', '.')
    @product.regular_price     = @item['regular_price'].gsub(',', '.')
    @product.sale_price        = @item['price'].gsub(',', '.')
    @product.sku               = @product.external_id
  end

  def set_classification
    result = []
    %w[categories brands genders disciplines].map do |classification|
      # TODO: remove JSON.parse when from API return correct hash format
      subcategories = JSON.parse(@item[classification])
      result += Subcategory.build_in_batch(subcategories, classification)
    end
    @product.subcategory_ids = result.pluck(:id).uniq.compact
  end

  def set_variations
    # TODO: remove JSON.parse when from API return correct hash format
    variations = JSON.parse(@item['variations'])
    @product.variations = variations
  end
end
