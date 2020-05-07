class CreateClassifications < ActiveRecord::Migration[6.0]
  def change
    create_table :classifications do |t|
      t.string :external_id
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
