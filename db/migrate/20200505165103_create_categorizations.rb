class CreateCategorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :categorizations do |t|
      t.references :classification
      t.references :product

      t.timestamps
    end
  end
end
