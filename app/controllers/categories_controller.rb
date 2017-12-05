class CategoriesController < InheritedResources::Base

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, notice: 'can\'t create category' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def category_params
      params.require(:category).permit(:title, :parent_category_id)
    end
end

