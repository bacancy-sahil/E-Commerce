# frozen_string_literal: true

# ProductsController
class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.all
  end

  def get_sub_category
    a = params[:categoryId]
    @subCategory = SubCategory.find_by(category_id: a)
    render json: {
      result: @subCategory
    }
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.delete
    redirect_to products_path
  end

  def getSubCategoryByCategory
    @category = Category.find(params[:categoryId])
  end

  def product_params
    params.require(:product).permit(:category_id, :sub_category_id, :name, :status, :price, :description, :quentity, :image1, :image2, :image3, :brand_id)
  end
end
