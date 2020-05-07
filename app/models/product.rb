# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  EXCLUDE_KEYS = %i[id external_id type_product weight color dimensions
                    product_related_ids parent_id brands genders disciplines
                    variations tags images links store_id metadata_attributes
                    metadata_default_attributes menu_order menu_data
                    grouped_products date_created date_modified 
                    created_at updated_at].freeze

  STATUSES = %i[draft pending private publish future].freeze

  belongs_to :store
  has_many :categorizations
  has_many :classifications, through: :categorizations
  has_and_belongs_to_many :subcategories

  validates :external_id, uniqueness: true

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
      create: to_create.as_json(except: EXCLUDE_KEYS, methods: :categories),
      update: to_update.as_json(except: EXCLUDE_KEYS, methods: :categories)
    }
  end

  def categories
    subcategories.map { |sub| { id: sub.woocommerce_id } }
  end

  def parse_date(value)
    return '' if value.blank? || value.eql?('null')

    Date.strptime(value, '%d/%m/%y').strftime('%Y/%m/%d')
  end
end
