class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false, unique: true
      t.string :url_woocommerce, null: false, unique: true
      t.string :url_external_api, null: false, unique: true
      t.string :sku, null: false, unique: true
      t.text :secret_key, null: false, unique: true
      t.text :customer_key, null: false, unique: true
      t.jsonb :metadata, null: false, unique: true, default: {}

      t.timestamps
    end
  end
end
