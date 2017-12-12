class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
    # debugger
  end
end
