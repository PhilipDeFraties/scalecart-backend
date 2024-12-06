class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.all
    render_success(@products)
  end

  # GET /products/:id
  def show
    render_success(@product)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render_success(@product, status: :created)
    else
      render_error(@product.errors.full_messages, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      render_success(@product)
    else
      render_error(@product.errors.full_messages, status: :unprocessable_entity)
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
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
