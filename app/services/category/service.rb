# frozen_string_literal: true

# Category Service class for sync subcategories in woocommerce
class Category::Service
  def self.sync_from_rails_to_woocommerce
    Store.find_each do |store|
      @woo            = WooCommerce::API.new(*store.data_to_woocommerce)
      @woo_categories = @woo.categories
      @subcategories  = store.subcategories_by_products
      process_categories
    end
  end

  def self.process_categories
    Classification.find_each do |classification|
      category_woocommerce = @woo_categories
                             .select { |x| x['slug'] == classification.slug }

      # Get only subcategories from this store in this classfication
      subcategories = classification.subcategories.where(id: @subcategories)

      subcategories.each do |subcategory|
        # Validates if subcategory exists in category woocommerce
        subcat_woocommerce = @woo_categories
                             .select { |x| x['slug'] == subcategory.slug }

        # Classifications are father categories in woocommerce
        # Subcategories are child categories in woocommerce, and also
        # categories from api cimo
        args = [subcat_woocommerce, subcategory, category_woocommerce, @woo]
        subcategory.create_or_update_by_woocommerce(*args)
      end
    end
  end
end
