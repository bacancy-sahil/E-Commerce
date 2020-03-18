# frozen_string_literal: true

# CategoryContoller.
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def set_category
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def destroy
    redirect_to categories_path if @category.destroy
  end

  def show; end

  def category_params
    params.require(:category).permit(:name, :status)
  end
end
