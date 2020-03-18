# frozen_string_literal: true

# CategoryContoller.
class CategoriesController < ApplicationController
before_action :authenticate_user!

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to categories_path
      else
        render 'edit'
      end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :status)
  end
end
1