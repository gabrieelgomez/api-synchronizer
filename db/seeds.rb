# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

classifications = [
  {
    name: 'Categorias',
    slug: 'categories',
    id: 30
  },
  {
    name: 'Marcas',
    slug: 'brands',
    id: 26
  },
  {
    name: 'Géneros',
    slug: 'genders',
    id: 28
  },
  {
    name: 'Disciplinas',
    slug: 'disciplines',
    id: 29
  }
]

classifications.each do |classification|
  Classification.create!(
    id: classification[:id],
    external_id: classification[:id],
    name: classification[:name],
    slug: classification[:slug]
  )
end
p 'Classifications created'
