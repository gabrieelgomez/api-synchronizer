# frozen_string_literal: true

# Categorization model
class Categorization < ApplicationRecord
  belongs_to :classification
  belongs_to :product
end
