# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  # For woocommerce_rest_product_invalid_id
  EXCLUDE_KEYS = %i[id external_id type_product weight color dimensions
                    product_related_ids parent_id brands genders disciplines
                    variations tags images links store_id metadata_attributes
                    metadata_default_attributes menu_order menu_data
                    grouped_products date_created date_modified
                    created_at updated_at woocommerce_id].freeze

  STATUSES = %w[draft pending private publish future].freeze

  TYPES = %w[simple grouped external variable].freeze

  belongs_to :store
  has_many :categorizations
  has_many :classifications, through: :categorizations
  has_and_belongs_to_many :subcategories

  validates :external_id, uniqueness: true
  validates :status, inclusion: { in: STATUSES }
  validates :type_product, inclusion: { in: TYPES }

  def self.define_create_and_update(products_rails, products_woo)
    to_create = []
    to_update = []

    products_rails.includes(:subcategories).each do |item|
      product = find_or_create_in_woocommerce(products_woo, item)
      product.nil? ? to_create.push(item) : to_update.push(product)
    end

    { to_create: to_create, to_update: to_update }
  end

  def self.find_or_create_in_woocommerce(products_woo, product)
    result = products_woo.select { |hash| hash['sku'] == product.external_id }
    result.any? ? product : nil
  end

  def self.build_json(to_create, to_update)
    {
      create: to_create.map(&:as_json_with_attributes),
      update: to_update.map(&:as_json_with_attributes_update)
    }
  end

  def as_json_with_attributes
    as_json(except: EXCLUDE_KEYS, methods: :categories)
      .merge(attributes: metadata_attributes,
             default_attributes: metadata_default_attributes,
             type: type_product)
  end

  def as_json_with_attributes_update
    as_json(except: EXCLUDE_KEYS, methods: :categories)
      .merge(attributes: metadata_attributes,
             default_attributes: metadata_default_attributes,
             type: type_product,
             id: woocommerce_id)
  end

  # Get categories with match in woocommerce
  def categories
    subcategories.map { |sub| { id: sub.woocommerce_id } }
  end

  # This is attributes field in woocommerce
  def metadata_attributes
    result = []

    woocommerce_attributes.each do |name_attribute|
      result.push({ name: name_attribute,
                    position: 0,
                    visible: true,
                    variation: true,
                    options: option_attributes(name_attribute) })
    end
    result
  end

  # This is default_attributes in woocommerce
  def metadata_default_attributes
    [{
      name: woocommerce_attributes.first,
      option: option_attributes(woocommerce_attributes.first).first
    }]
  end

  # For get all variations types, example Talla, Color
  def woocommerce_attributes
    variations.map { |x| x['attribute'] }.uniq
  end

  # For get all vartiations one attribute, for example ['L', 'M'] for Talla
  def option_attributes(name_attribute)
    variations.group_by { |hash| hash['attribute'] }[name_attribute]
              .map { |x| x['name'] }
  end

  # Build json variations valid to wocommerce
  def build_json_variations
    result = []
    variations.each do |variation|
      result.push(
        {
          sale_price: variation['sale_price'],
          regular_price: variation['regular_price'],
          sku: variation['sku'],
          on_sale: true,
          status: 'publish',
          purchasable: true,
          stock_quantity: variation['stock_quantity'],
          manage_stock: true,
          stock_status: 'instock',
          attributes: [
            {
              name: variation['attribute'],
              option: variation['name']
            }
          ]
        }
      )
    end
    result
  end
end
