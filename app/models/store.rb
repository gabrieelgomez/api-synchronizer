# frozen_string_literal: true

# Store model
class Store < ApplicationRecord
  has_many :products
  validates :name, :url, :sku, :secret_key, :customer_key,
            :metadata, uniqueness: true, presence: true

  def self.initialize_for(store)
    find_or_initialize_by(
      name: store[:name],
      url: store[:url],
      sku: store[:sku],
      secret_key: store[:secret_key],
      customer_key: store[:customer_key],
      metadata: store[:metadata]
    )
  end

  def subcategory_parse_ids
    products.includes(:subcategories).map(&:subcategory_ids).flatten.uniq.sort
  end

  def data_to_woocommerce
    [
      url,
      secret_key,
      customer_key,
      metadata.symbolize_keys
    ]
  end
end
