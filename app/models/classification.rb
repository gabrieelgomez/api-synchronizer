# frozen_string_literal: true

# Classification model
class Classification < ApplicationRecord
  TYPES = %w[categories brands genders disciplines].freeze

  has_many :categorizations
  has_many :products, through: :categorizations
  has_many :subcategories

  validates :slug, uniqueness: true
  validates :slug, inclusion: { in: TYPES }

  def subcategories_by(data)
    subcategories.where(id: data)
  end
end
