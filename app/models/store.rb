# frozen_string_literal: true

# Store model
class Store < ApplicationRecord
  has_many :products
  validates :name, :url_woocommerce, :url_external_api, :metadata,
            :secret_key, :customer_key, :sku, uniqueness: true, presence: true

  def self.initialize_for(store)
    find_or_initialize_by(
      name: store[:name],
      url_woocommerce: store[:url_woocommerce],
      url_external_api: store[:url_external_api],
      sku: store[:sku],
      secret_key: store[:secret_key],
      customer_key: store[:customer_key],
      metadata: store[:metadata]
    )
  end

  def subcategories_by_products
    products.includes(:subcategories).map(&:subcategories).flatten.uniq.sort
  end

  def data_to_woocommerce
    [
      url_woocommerce,
      secret_key,
      customer_key,
      metadata.symbolize_keys
    ]
  end
end
