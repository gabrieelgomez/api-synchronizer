# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_06_210039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categorizations", force: :cascade do |t|
    t.bigint "classification_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classification_id"], name: "index_categorizations_on_classification_id"
    t.index ["product_id"], name: "index_categorizations_on_product_id"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "sku", null: false
    t.integer "woocommerce_id"
    t.string "name"
    t.string "slug"
    t.string "permalink"
    t.string "date_created"
    t.string "date_modified"
    t.string "type_product", default: "simple"
    t.string "status", default: "publish"
    t.boolean "featured"
    t.string "catalog_visibility"
    t.string "description"
    t.string "short_description"
    t.string "price"
    t.string "regular_price"
    t.string "sale_price"
    t.string "date_on_sale_from"
    t.string "date_on_sale_to"
    t.boolean "on_sale"
    t.boolean "purchasable"
    t.integer "total_sales"
    t.boolean "virtual"
    t.string "external_url"
    t.string "tax_status"
    t.string "tax_class"
    t.boolean "manage_stock"
    t.integer "stock_quantity", default: 0
    t.string "stock_status"
    t.string "backorders"
    t.boolean "backorders_allowed"
    t.boolean "backordered"
    t.boolean "sold_individually"
    t.string "weight"
    t.string "color"
    t.jsonb "dimensions"
    t.boolean "shipping_required"
    t.boolean "shipping_taxable"
    t.string "shipping_class"
    t.string "shipping_class_id"
    t.boolean "reviews_allowed"
    t.string "average_rating"
    t.string "rating_count"
    t.jsonb "product_related_ids", default: {}
    t.jsonb "upsell_ids", default: {}
    t.jsonb "cross_sell_ids", default: {}
    t.string "parent_id"
    t.string "purchase_note"
    t.jsonb "variations", default: {}
    t.jsonb "tags", default: {}
    t.jsonb "images", default: {}
    t.jsonb "metadata_attributes", default: {}
    t.jsonb "metadata_default_attributes", default: {}
    t.jsonb "grouped_products", default: {}
    t.string "menu_order"
    t.jsonb "menu_data"
    t.string "links"
    t.bigint "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "products_subcategories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "subcategory_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_products_subcategories_on_product_id"
    t.index ["subcategory_id"], name: "index_products_subcategories_on_subcategory_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "url_woocommerce", null: false
    t.string "url_external_api", null: false
    t.string "sku", null: false
    t.text "secret_key", null: false
    t.text "customer_key", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer "woocommerce_id"
    t.string "name"
    t.string "slug"
    t.bigint "classification_id"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["classification_id"], name: "index_subcategories_on_classification_id"
    t.index ["slug"], name: "index_subcategories_on_slug", unique: true
  end

end
