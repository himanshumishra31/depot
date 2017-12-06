class Order < ApplicationRecord
  scope :by_date, -> (from = Time.current.midnight, to = Time.current.end_of_day) { where created_at: from..to }
  has_many :line_items, dependent: :destroy
  belongs_to :user
  enum pay_type: {
    "Check" => 0,
    "Credit card" => 1,
    "Purchase order" => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |line_item| line_item.total_price }
  end
end
