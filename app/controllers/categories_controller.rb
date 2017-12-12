class CategoriesController < InheritedResources::Base
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  # before_action :all_categories, only: [:show_categories]

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, notice: 'Can\'t create category due to errors' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to @category, notice: 'Category was successfully destroyed.' }
      else
        format.html { redirect_to @category, notice: 'Can\'t delete category associated to products' }
      end
      format.json { head :no_content }
    end
  end

  def show_categories
  end

  private

    def category_params
      params.require(:category).permit(:title, :parent_category_id)
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def all_categories
      @categories = Category.all
    end
end

