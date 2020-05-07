# frozen_string_literal: true

# CategoriesStore class
class CategoriesStore
  def self.sync_from_rails_to_woocommerce
    Store.all.each do |store|
      subcategories_ids = store.subcategory_parse_ids
      woocommerce = WooCommerce::API.new(*store.data_to_woocommerce)

      Classification.all.each do |classification|
        subcategories = classification.subcategories_by(subcategories_ids)
        category_woocommerce = woocommerce.get('products/categories',
                                               { slug: classification.slug })
                                          .parsed_response

        subcategories.each do |subcategory|
          # Validates if subcategory exists in category woocommerce
          subcategory_woocommerce = woocommerce.get('products/categories',
                                                    { slug: subcategory.slug })
                                               .parsed_response

          # Classifications are father categories in woocommerce
          # Subcategories are child categories in woocommerce, and also
          # categories from api cimo
          subcategory.create_or_update_by_woocommerce(subcategory_woocommerce,
                                                      category_woocommerce)
        end
      end

    end
  end
end
