# frozen_string_literal: true

# clientController
class ClientController < ApplicationController
  before_action :authenticate_user!, only: %i[new cart order]

  def new
    @user = User.new
    @brand = @user.build_brand
  end

  def filterdatabyCat
    category = params[:catValue].to_i
    @products = Product.where("name LIKE :name1 AND category_id = :catid", name1: "#{params[:catInput]}%", catid: category)
  end

  def filterdata
    data = params[:filter]
    @products = if data == "Sorting A to Z"
        Product.order(name: :asc)
      elsif data == "Sorting Z to A"
        Product.order(name: :desc)
      elsif data == "Sorting Price High to Low"
        Product.order(price: :desc)
      elsif data == "Sorting Price Low to High"
        Product.order(price: :asc)
      else
        Product.all
      end
  end

  def search
    data = params[:data]
    @products = Product.search(data)
  end

  def create
    @user = User.new
    @brand = Brand.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    if @user.save
      @brand.subscription_id = params[:user][:brand][:subscription_id]
      @brand.name = params[:user][:brand][:name]
      @brand.user_id = @user.id
      @brand.save
      redirect_to brands_done_path
    else
      render "/brands/new"
    end
  end

  def category
    @products = Product.where(category_id: params[:id])
  end

  def addComment
    Comment.create(product_id: params[:productId], user_id: params[:customerId], description: params[:description])
  end

  def subCategory
    subCategoryId = params[:id]
    @products = Product.where(sub_category_id: subCategoryId)
  end

  def updateComment
    comment = Comment.find(params[:commentId])
    comment.update(description: params[:description])
  end

  def brand
    brandId = params[:id]
    @products = Product.where(brand_id: brandId)
  end

  def product
    @product = Product.find(params[:id])
    if user_signed_in?
      if Mappingtable.exists?(user_id: current_user.id, product_id: params[:id])
      else
        @map = Mappingtable.new
        @map.product_id = params[:id]
        @map.user_id = current_user.id
        @map.save
      end
    end
  end

  def AddToCart
    productId = params[:productId]
    @cart = Cart.new
    @cart.user_id = current_user.id
    @cart.product_id = params[:productId]
    @cart.quentity = 1
    @cart.save
    redirect_to action: "cart"
  end

  def cart
    @carts = Cart.where(["user_id= ?", current_user.id])
  end

  def orderConfirm
    @carts = Cart.where(["user_id= ?", current_user.id])
  end

  def home
    @category = Category.where(status: true)
    @products = Product.where(status: true)
    @products_order = Product.order("created_at DESC").take(3)
  end

  def deleteCart
    @cart = Cart.find(params[:id])
    @cart.delete
    redirect_to action: "cart"
  end

  def checkout
    @carts = Cart.where(user_id: current_user.id)
    for cart in @carts.each
      productQuentity = cart.product.quentity
      productName = cart.product.name
      cartQuentity = cart.quentity
      if productQuentity > 0
        if productQuentity >= cartQuentity
        else
          flash[:notice] = "You can add only " + productQuentity.to_s + " Quentity of this " + productName + "."
          return redirect_to client_cart_path
        end
      else
        flash[:notice] = "Product " + productName + " out of stock."
        return redirect_to client_cart_path
      end
    end
    for cart in @carts.each
      productQuentity = cart.product.quentity
      productName = cart.product.name
      cartQuentity = cart.quentity
      a = productQuentity - cartQuentity
      cart.product.update(quentity: a)
    end
    @order = Cart.where(["user_id= ?", current_user.id])
    order
  end

  def updateCartValue
    productId = params[:productId]
    quentity = params[:quentity]
    Cart.where(user_id: current_user.id, product_id: productId).update(quentity: quentity)
    puts "done"
  end

  def order
    @carts = Cart.where(["user_id= ?", current_user.id])
    date = DateTime.now
    dates = date.strftime("%Y-%m-%d %H:%M")
    for cart in @carts.each
      @order = Order.new
      @order.product_id = cart.product_id
      @order.user_id = cart.user_id
      @order.quantity = cart.quentity
      @order.created_at = dates
      @order.save
      @cart1 = Cart.find(cart.id)
      @cart1.delete
    end
  end

  def orderHistorys
    @orders = Order.where(["status= ?", true])
    for order in @orders.each
      @orderHistory = OrderHistory.new
      @orderHistory.name = order.product.name
      @orderHistory.description = order.product.description
      @orderHistory.price = order.product.price
      @orderHistory.quantity = order.quentity
      @orderHistory.quantity = order.user_id
      @orderHistory.save
      @order = Order.find(order.id)
      @order.delete
    end
  end

  def orderHistory
    @order = OrderHistory.where(user_id: current_user.id)
  end

  def orderConfirm
    @carts = Cart.where(["user_id= ?", current_user.id])
    for cart in @carts.each
      @order = Order.new
      @order.product_id = cart.product_id
      @order.user_id = cart.user_id
      @order.quantity = cart.quentity
      @order.save
      @cart1 = Cart.find(cart.id)
      @cart1.delete
    end
    @order = Order.where(["user_id= ?", current_user.id])
  end

  def deleteComment
    comment = params[:commentId]
    Comment.delete(comment)
  end

  def updateLike
    commentId = params[:commentId]
    userId = params[:userId]
    if Like.exists?(comment_id: commentId, user_id: userId)
      like = Like.find_by(comment_id: commentId, user_id: userId)
      if like.likeValue
        like.update(likeValue: false)
      else
        like.update(likeValue: true)
      end
    else
      Like.create(comment_id: commentId, user_id: userId, likeValue: false)
    end
    # product Page code
    @product = Product.find(params[:id])
    if user_signed_in?
      if Mappingtable.exists?(user_id: current_user.id, product_id: params[:id])
      else
        @map = Mappingtable.new
        @map.product_id = params[:id]
        @map.user_id = current_user.id
        @map.save
      end
    end
  end

  def set_params
    params.require(:user).permit(:email, :password, brand_attributes: %i[subscription_id name])
  end

  def updateProfile
    @user = User.find(params[:id])
    @user.update(firstname: params[:fname], lastname: params[:lnane], phone_number: params[:pnumber], address: params[:address], pincode: params[:pincode])
  end
end
