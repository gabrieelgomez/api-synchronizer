class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.string :external_id, null: false, unique: true
      t.integer :woocommerce_id
      t.string :name
      t.string :slug
      t.references :classification

      t.timestamps
    end
  end
end
