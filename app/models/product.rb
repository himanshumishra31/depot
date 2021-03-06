class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "Invalid Image url" unless value =~ %r{\.(gif|jpg|png)\Z}i
  end
end

class PriceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << " should be greater than discount price" if record.price < record.discount_price
  end
end

class Product < ApplicationRecord
  scope :enabled, -> { where(enabled: true) }


  #validations
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: :price?
  validates :title, uniqueness: true
  validates :permalink, presence: true
  validates :permalink, uniqueness: true, format: { with: /\A(([a-zA-Z\d]+-){2,}([a-zA-Z\d]+))/ }, allow_blank: true
  validates :description, length: { in: 5..10 }
  validates :image_url, image_url: true, allow_blank: true
  validate :price_cannot_be_less_than_discount_price, if: :discount_price?
  # validates :price, price: true, if: :discount_price?

  #callbacks
  before_validation :set_default_title, unless: :title?
  before_validation :set_discount_price, unless: :discount_price?
  after_create :increment_count

  # associations
  has_many :line_items, dependent: :restrict_with_error
  has_many :carts, through: :line_items
  belongs_to :category, counter_cache: :count
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  private

    def price_cannot_be_less_than_discount_price
      errors.add(:price, "should be greater than discount price") if price < discount_price
    end

    def set_default_title
      self.title = 'abc'
    end

    def set_discount_price
      self.discount_price = price
    end

    def increment_count
      parent_category = Category.find(category_id).parent_category_id
      if parent_category.present?
        Category.increment_counter(:count, parent_category)
      end
    end
end
