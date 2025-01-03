class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]

  # GET /categories
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  # GET /categories/:id
  def show
    render json: @category, include: :subcategories, status: :ok
  end

  # POST /categories
  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /categories/:id
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Couldn't find Category with 'id'=#{params[:id]}" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:name, :description, :parent_id)
  end
end
