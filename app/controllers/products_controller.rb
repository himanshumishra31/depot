class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    respond_to do |format|
      format.json { render json: Product.select('products.title AS Name', 'categories.title AS Category').joins(:category) }
      format.html
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
    save_product_images
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    save_product_images

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        ActionCable.server.broadcast 'products', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      if @product.errors.empty?
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      else
        format.html { redirect_to products_url, notice: 'Can\'t delete product due to errors' }
      end
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :image_url, :discount_price, :enabled, :permalink, :category_id, image_attributes: [:name, :content_type])
    end

    def save_product_images
      3.times do |index|
        image = params[:product]["image#{ index + 1 }"]
        path = File.join Rails.root, 'public', 'images'
        FileUtils.mkdir_p(path) unless File.exist?(path)
        File.open(File.join(path, image.original_filename), 'wb') do |file|
          file.puts image.read
        end
        @product.images.build(name: image.original_filename, content_type: image.content_type).save
      end
    end

end
