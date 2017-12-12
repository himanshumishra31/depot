class Category < ApplicationRecord

  # validations
  validates :title, presence: true
  validates :title, uniqueness: { scope: :parent_category }, allow_blank: true, if: :title?

  # callbacks
  before_save :parent_category_should_exist?
  before_save :parent_category_should_not_be_sub_category

  # associations
  has_many :sub_categories, class_name: 'Category', dependent: :destroy, foreign_key: "parent_category_id"
  belongs_to :parent_category, class_name: "Category", required: false
  has_many :products, dependent: :restrict_with_error
  has_many :sub_category_products, through: :sub_categories, source: :products


  private

  def parent_category_should_exist?
    if parent_category_id?
      unless Category.exists?(parent_category_id)
        errors.add(:title, 'Category must exist')
        throw :abort
      end
    end
  end

  def parent_category_should_not_be_sub_category
    if parent_category_id?
      if Category.find(parent_category_id).parent_category_id?
        errors.add(:parent_category_id, 'is itself a sub category')
        throw :abort
      end
    end
  end

end
