# frozen_string_literal: true

# SubCategoriesController
class SubCategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @subCategory = SubCategory.all
  end

  def new
    @category = Category.all
    @subCategory = SubCategory.new
  end

  def create
    @subCategory = SubCategory.new(subcat_params)
    status = params[:sub_category][:status]
    params[:status] = status.to_i
    a = params[:category_id]
    @subCategory.category_id = a
    if @subCategory.save
      redirect_to sub_categories_path
    else
      render 'new'
    end
  end

  def edit
    @subCategory = SubCategory.find(params[:id])
  end

  def show
    @subCategory = SubCategory.find(params[:id])
  end

  def update
    @subCategory = SubCategory.find(params[:id])
    status = params[:sub_category][:status]
    params[:status] = status.to_i
    a = params[:category_id]
    @subCategory.category_id = a
    if @subCategory.update(subcat_params)
      redirect_to sub_categories_path
    else
      render 'new'
    end
  end

  def destroy
    @subCategory = SubCategory.find(params[:id])
    @subCategory.destroy
    redirect_to sub_categories_path
  end

  def subcat_params
    params.require(:sub_category).permit(:category_id, :name, :status)
  end
end
