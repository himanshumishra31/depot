class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << options[:message] unless value =~ %r{\.(gif|jpg|png)\Z}i
  end
end

class PriceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << options[:message] if price < discount_price
  end
end

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: :price?
  validates :title, uniqueness: true
  validates :permalink, uniqueness: true, format: { with: /\A(([a-zA-Z\d]+-){2,}([a-zA-Z\d]+))/ }
  vaildates :description, length: { in: 5..10 }
  validates :image_url, image_url: true, allow_blank: true
  validate :price_cannot_be_less_than_discount_price
  validates :price, price: true
  private
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, t(".Line Items present")
        throw :abort
      end
    end

    def price_cannot_be_less_than_discount_price
      errors.add(:price, t(".should be greater than discount_price") if price < discount_price
    end
end
