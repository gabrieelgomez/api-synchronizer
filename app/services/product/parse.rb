# frozen_string_literal: true

# Parse class for loop each store
class Product::Parse
  # Class method for loop items from store anda validate his size
  def self.sync_rails_from_api
    Store.find_each do |store|
      # TODO: when exist api for each store, should be use HTTParty
      # response = HTTParty.get(store.url_external_api)

      # TODO: remove below two lines when exists api for each store
      response = open('docs/cimo_api_example.json').read
      response = JSON.parse(response)

      break unless response['items'].size.positive?

      Product::Setter.sync_products_from_api(response['items'], store)
    end
  end
end
