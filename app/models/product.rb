# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  validates :external_id, uniqueness: true
end
