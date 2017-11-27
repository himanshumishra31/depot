class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart
  validates :product_id, uniqueness: { scope: :cart_id, message: t('.duplicate entry') }
  def total_price
    product.price * quantity
  end
end
