# frozen_string_literal: true

# Classifications are categories in woocommerce
classifications = [
  {
    name: 'Categorias',
    slug: 'categories'
  },
  {
    name: 'Marcas',
    slug: 'brands'
  },
  {
    name: 'Géneros',
    slug: 'genders'
  },
  {
    name: 'Disciplinas',
    slug: 'disciplines'
  }
]

classifications.each do |classification|
  Classification.create!(
    external_id: SecureRandom.hex(3),
    name: classification[:name],
    slug: classification[:slug]
  )
end
p 'Classifications created'
