class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.integer :woocommerce_id
      t.string :name
      t.string :slug
      t.references :classification

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_index :subcategories, :slug, unique: true
  end
end
