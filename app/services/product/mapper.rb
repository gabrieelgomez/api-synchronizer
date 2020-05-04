# frozen_string_literal: true

# Product module of Product model
# Mapper class for loop each item from cimo api to valid values
class Product::Mapper
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def external_id
    @object['id']
  end

  def name
    @object['name']
  end

  def slug
    @object['slug']
  end

  def permalink
    @object['permalink']
  end

  def date_created
    @object['date_created']
  end

  def date_modified
    @object['date_modified']
  end

  def type
    @object['type']
  end

  def status
    @object['status']
  end

  def featured
    @object['featured']
  end

  def catalog_visibility
    @object['catalog_visibility']
  end

  def description
    @object['description']
  end

  def short_description
    @object['short_description']
  end

  def sku
    @object['sku']
  end

  def price
    @object['price']
  end

  def regular_price
    @object['regular_price']
  end

  def sale_price
    @object['sale_price']
  end

  def date_on_sale_from
    @object['date_on_sale_from']
  end

  def date_on_sale_to
    @object['date_on_sale_to']
  end

  def on_sale
    @object['on_sale']
  end

  def purchasable
    @object['purchasable']
  end

  def total_sales
    @object['total_sales']
  end

  def virtual
    @object['virtual']
  end

  def external_url
    @object['external_url']
  end

  def tax_status
    @object['tax_status']
  end

  def tax_class
    @object['tax_class']
  end

  def manage_stock
    @object['manage_stock']
  end

  def stock_quantity
    @object['stock_quantity']
  end

  def stock_status
    @object['stock_status']
  end

  def backorders
    @object['backorders']
  end

  def backorders_allowed
    @object['backorders_allowed']
  end

  def backordered
    @object['backordered']
  end

  def sold_individually
    @object['sold_individually']
  end

  def weight
    @object['weight']
  end

  def color
    @object['color']
  end

  def dimensions
    @object['dimensions']
  end

  def shipping_required
    @object['shipping_required']
  end

  def shipping_taxable
    @object['shipping_taxable']
  end

  def shipping_class
    @object['shipping_class']
  end

  def shipping_class_id
    @object['shipping_class_id']
  end

  def average_rating
    @object['average_rating']
  end

  def rating_count
    @object['rating_count']
  end

  def product_related_ids
    @object['product_related_ids']
  end

  def upsell_ids
    @object['upsell_ids']
  end

  def cross_sell_ids
    @object['cross_sell_ids']
  end

  def parent_id
    @object['parent_id']
  end

  def purchase_note
    @object['purchase_note']
  end

  def categories
    @object['categories']
  end

  def brands
    @object['brands']
  end

  def genders
    @object['genders']
  end

  def tags
    @object['tags']
  end

  def variations
    @object['variations']
  end

  def images
    @object['images']
  end

  def attributes
    @object['attributes']
  end

  def default_attributes
    @object['default_attributes']
  end

  def grouped_products
    @object['grouped_products']
  end

  def menu_order
    @object['menu_order']
  end

  def menu_data
    @object['menu_data']
  end

  def links
    @object['links']
  end
end
