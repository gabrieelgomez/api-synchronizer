class CreateProductsSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :products_subcategories do |t|
      t.references :product
      t.references :subcategory

      t.timestamps
    end
  end
end
