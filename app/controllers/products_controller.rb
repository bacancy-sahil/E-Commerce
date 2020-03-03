class ProductsController < ApplicationController
before_action :authenticate_user!
	def index
		@product = Product.all
	end
	
	def get_sub_category
		binding.pry
		a=params[:categoryId]
		@subCategory=SubCategory.find_by(category_id: a)
		render json: {
			result: @subCategory
		}
	end

	def new
		@product =Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save!
			redirect_to products_path
		else
			redirect_to products_path
		end
	end

	def show
		@product = Product.find(params[:id]) 
	end

	def edit
		@product = Product.find(params[:id]) 
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			redirect_to products_path
		else
			redirect_to products_path
		end
	end

	def destroy
		binding.pry
		@product = Product.find(params[:id])
		if @product.delete
			redirect_to products_path
		else
			redirect_to products_path
		end
	end

	def getSubCategoryByCategory
		byebug
		@category=Category.find(params[:categoryId])
	end
	
	def product_params
		params.require(:product).permit(:category_id,:sub_category_id,:name,:status,:price,:description,:quentity,:image1,:image2,:image3,:brand_id)
	end




end
