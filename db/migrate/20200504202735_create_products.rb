class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, null: false, unique: true
      t.integer :woocommerce_id
      t.string :name
      t.string :slug
      t.string :permalink
      t.string :date_created
      t.string :date_modified
      t.string :type_product, default: 'simple'
      t.string :status, default: 'publish'
      t.boolean :featured
      t.string :catalog_visibility
      t.string :description
      t.string :short_description
      t.string :price
      t.string :regular_price
      t.string :sale_price
      t.string :date_on_sale_from
      t.string :date_on_sale_to
      t.boolean :on_sale
      t.boolean :purchasable
      t.integer :total_sales
      t.boolean :virtual
      t.string :external_url
      t.string :tax_status
      t.string :tax_class
      t.boolean :manage_stock
      t.integer :stock_quantity, default: 0
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
      t.jsonb :product_related_ids, default: {}
      t.jsonb :upsell_ids, default: {}
      t.jsonb :cross_sell_ids, default: {}
      t.string :parent_id
      t.string :purchase_note
      t.jsonb :variations, default: {}
      t.jsonb :tags, default: {}
      t.jsonb :images, default: {}
      t.jsonb :metadata_attributes, default: {}
      t.jsonb :metadata_default_attributes, default: {}
      t.jsonb :grouped_products, default: {}
      t.string :menu_order
      t.jsonb :menu_data
      t.string :links
      t.references :store

      t.timestamps
    end
  end
end
