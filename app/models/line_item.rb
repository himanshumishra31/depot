class LineItem < ApplicationRecord
  belongs_to :order, required: false
  belongs_to :product
  belongs_to :cart, counter_cache: :line_items_count
  validates :product_id, uniqueness: { scope: :cart_id, message: "duplicate entry" }

  def total_price
    product.price * quantity
  end
end
