# frozen_string_literal: true

# Subcategory model
class Subcategory < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :classification

  # Find for create subcategory in woocommerce or update subcategory in rails
  def create_or_update_by_woocommerce(subcategory_woocommerce, subcategory, father_category, woocommerce)
    # if already exists subcategory in woocommerce
    if subcategory_woocommerce.any?
      sub_cat_woocommerce = subcategory_woocommerce.first
      update!(woocommerce_id: sub_cat_woocommerce['id'])
    else
      # Create subcategory from parent category_woocommerce
      data = subcategory.build_create_ecommerce_data(father_category)

      # Create a subcategory in woocommerce
      res = woocommerce.create_category(data)
      update!(woocommerce_id: res['id'])
    end
  end

  # Correct format for create category in woocommerce
  def build_create_ecommerce_data(father_category)
    {
      name: name,
      slug: slug,
      parent: father_category.first['id']
    }
  end
end
