# frozen_string_literal: true

require 'open-uri'

# StoreServices Service for syncronizers stores
class StoreService
  # Sync stores from api cimo
  def self.sync_from_api_to_rails
    # TODO: change por HTTParty when exists store endpoint
    response = open('app/doc/cimo_api_stores_example.json').read
    response = JSON.parse(response)

    response['data'].each do |store|
      store = Store.initialize_for(store)
      store.save
    end
  end

  # Sync products for each store from rails through cimo api
  def self.sync_from_rails_to_woocommerce
    Store.all.each do |store|
      woocommerce_store = WooCommerce::Batch.new(*store.data_to_woocommerce)
      woocommerce_store.build_in_batch(store.products)
    end
  end
end
