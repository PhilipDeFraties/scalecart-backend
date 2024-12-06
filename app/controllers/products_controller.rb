class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    logger.info "Fetching all products"
    @products = Product.all
    render_success(@products)
  end

  # GET /products/:id
  def show
    logger.info "Fetching product with ID: #{@product.id}"
    render_success(@product)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      logger.info "Product created successfully: #{@product.attributes}"
      render_success(@product, status: :created)
    else
      logger.warn "Failed to create product: #{@product.errors.full_messages}"
      render_error(@product.errors.full_messages, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      logger.info "Product updated successfully: #{@product.attributes}"
      render_success(@product)
    else
      logger.warn "Failed to update product: #{@product.errors.full_messages}"
      render_error(@product.errors.full_messages, status: :unprocessable_entity)
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    logger.info "Product deleted with ID: #{@product.id}"
    render_success(nil, status: :no_content)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_quantity)
  end
end
