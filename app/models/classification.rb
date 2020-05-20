# frozen_string_literal: true

# Classification model
class Classification < ApplicationRecord
  TYPES = %w[categories brands genders disciplines].freeze
  KEYS_EXCEPTIONS = %w[id].freeze

  has_many :categorizations
  has_many :products, through: :categorizations
  has_many :subcategories

  validates :slug, uniqueness: true
  validates :slug, inclusion: { in: TYPES }

  def self.create_subcategories(item)
    result = []
    find_each do |classification|
      subcategories = item[classification.slug]
      result += classification.upsert_all_subcategories(subcategories)
                              .rows.flatten
    end
    result
  end

  def upsert_all_subcategories(data)
    data.map do |subcategory|
      subcategory['classification_id'] = id
      subcategory.except!(*KEYS_EXCEPTIONS)
    end
    Subcategory.upsert_all(data, unique_by: %i[slug], returning: %w[id])
  end
end
