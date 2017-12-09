module ProductsHelper
  def categories
    Category.pluck(:title, :id)
  end

end
