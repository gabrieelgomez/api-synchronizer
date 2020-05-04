class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :external_id
      t.string :name
      t.string :slug
      t.string :permalink
      t.datetime :date_created
      t.datetime :date_modified
      t.integer :type
      t.integer :status
      t.boolean :featured
      t.string :catalog_visibility
      t.string :description
      t.string :short_description
      t.string :sku
      t.string :price
      t.string :regular_price
      t.string :sale_price
      t.datetime :date_on_sale_from
      t.datetime :date_on_sale_to
      t.boolean :on_sale
      t.boolean :purchasable
      t.integer :total_sales
      t.boolean :virtual
      t.string :external_url
      t.string :tax_status
      t.string :tax_class
      t.boolean :manage_stock
      t.string :stock_quantity
      t.string :stock_status
      t.string :backorders
      t.boolean :backorders_allowed
      t.boolean :backordered
      t.boolean :sold_individually
      t.string :weight
      t.string :color
      t.jsonb :dimensions
      t.boolean :shipping_required
      t.boolean :shipping_taxable
      t.string :shipping_class
      t.string :shipping_class_id
      t.boolean :reviews_allowed
      t.string :average_rating
      t.string :rating_count
      t.jsonb :product_related_ids
      t.string :upsell_ids
      t.string :cross_sell_ids
      t.string :parent_id
      t.string :purchase_note
      t.jsonb :categories
      t.jsonb :brands
      t.jsonb :genders
      t.jsonb :disciplines
      t.jsonb :variations
      t.jsonb :tags
      t.jsonb :images
      t.string :metadata_attributes
      t.string :metadata_default_attributes
      t.string :grouped_products
      t.string :menu_order
      t.string :menu_data
      t.string :links

      t.timestamps
    end
  end
end
