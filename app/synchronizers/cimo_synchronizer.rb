# frozen_string_literal: true

require 'open-uri'

# CimoSynchronizer Service for syncronizers stores inventory
class CimoSynchronizer
  # Class method for sync each model in rails to woocommerce
  def self.sync
    # Service to synchronize stores in rails from available API stores
    Store::Service.sync_from_api_to_rails

    # Service to synchronize products in rails from API products
    Product::Parse.sync_rails_from_api

    # once the products have been uploaded, from these records all categories
    # and subcategories are created for each store
    # Service to synchronize available categories from API through products
    Category::Service.sync_from_rails_to_woocommerce

    # Service to synchronize products from rails for each store
    # to woocommerce products
    Store::Service.sync_from_rails_to_woocommerce
  end
end
