class Category < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true, allow_blank: true, unless: :parent_category_id?, if: :title?
  validates :title, uniqueness: true, allow_blank: true, if: :sub_category_exist?, if: :title?
  before_save :parent_category_should_exist?
  before_save :parent_category_should_not_be_sub_category

  private

  def sub_category_exist?
    # debugger
    Category.exists?(parent_category_id: parent_category_id) && !( parent_category_id.nil? )
  end

  def parent_category_should_exist?
    throw :abort unless Category.exists?(id: parent_category_id)
  end

  def parent_category_should_not_be_sub_category
    throw :abort if Category.find(parent_category_id).parent_category_id?
  end

end
