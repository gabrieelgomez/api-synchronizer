# frozen_string_literal: true

# Parse class for loop each store
class Product::Parse
  def self.sync_rails_from_api
    Store.all.each do |store|
      # TODO: remove this break conditiona when exists store's endpoint
      break unless store.sku == 'tiendas-plx'

      # TODO: when exist api for each store, should be use HTTParty
      # response = HTTParty.get(store.url)

      # TODO: remove below two lines when exists api for each store
      response = open('app/doc/cimo_api_example.json').read
      response = JSON.parse(response)

      break unless response['items'].size.positive?

      response['items'].map { |product| Product::Setter.set(product, store) }
    end
  end
end
