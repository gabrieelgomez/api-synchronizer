# frozen_string_literal: true

require 'open-uri'

# CimoSynchronizer Service for syncronizers stores
class CimoSynchronizer
  STAGING_URL = 'http://168.181.162.73/ords/pedidos_web2/vdatosiv'

  def self.synchronize
    # TODO: refactoring when exist url for stores using Product::Parse

    response = open('app/doc/cimo_api_example.json').read
    response = JSON.parse(response)

    # response = HTTParty.get(STAGING_URL)

    return unless response['items'].size.positive?

    response['items'].map { |item| Product::Setter.set(item) }
  end
end
