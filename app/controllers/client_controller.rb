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
    @products = Product.where('name LIKE :name1 AND category_id = :catid', name1: '#{params[:catInput]}%', catid: category)
  end

  def filterdata
    data = params[:filter]
    case data  
      when(data = "Sorting A to Z")
        @products = Product.order(name: :asc)
      when(data = "Sorting Z to A")
        @products = Product.order(name: :desc)
      when(data = "Sorting Price High to Low")
        @products = Product.order(price: :desc)
      when(data = "Sorting Price Low to High")
        @products = Product.order(price: :asc)
      else
        @products = Product.all
      end
  end

  def search
    @products = Product.search(params[:data])
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
      render '/brands/new'
    end
  end

  def category
    @products = Product.where(category_id: params[:id])
  end

  def addComment
    Comment.create(product_id: params[:productId], user_id: params[:customerId], description: params[:description])
  end

  def subCategory
    @products = Product.where(sub_category_id: params[:id])
  end

  def updateComment
    comment = Comment.find(params[:commentId])
    comment.update(description: params[:description])
  end

  def brand
    @products = Product.where(brand_id: params[:id])
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
    @cart = Cart.new
    @cart.user_id = current_user.id
    @cart.product_id = params[:productId]
    @cart.quantity = 1
    @cart.save
    redirect_to action: :cart
  end

  def cart
    @carts = Cart.where(['user_id= ?', current_user.id])
  end

  def orderConfirm
    @carts = Cart.where(['user_id= ?', current_user.id])
  end

  def home
    @category = Category.where(status: true)
    @products = Product.where(status: true)
    @products_order = Product.order('created_at DESC').take(3)
  end

  def deleteCart
    @cart = Cart.find(params[:id])
    @cart.delete
    redirect_to action: :cart
  end

  def checkout
    @carts = Cart.where(user_id: current_user.id)
    for cart in @carts.each
      productQuantity = cart.product.quantity
      productName = cart.product.name
      cartQuantity = cart.quantity
      if productQuantity > 0
        if productQuantity >= cartQuantity
        else
          flash[:notice] = 'You can add only ' + productQuantity.to_s + ' Quantity of this ' + productName + '.'
          return redirect_to client_cart_path
        end
      else
        flash[:notice] = 'Product ' + productName + ' out of stock.'
        return redirect_to client_cart_path
      end
    end
    @carts.each do |cart|
      productQuantity = cart.product.quantity
      productName = cart.product.name
      cartQuantity = cart.quantity
      a = productQuantity - cartQuantity
      cart.product.update(quantity: a)
    end
    @order = Cart.where(['user_id= ?', current_user.id])
    order
  end

  def updateCartValue
    Cart.where(user_id: current_user.id, product_id: params[:productId]).update(quantity: params[:quantity])
  end

  def order
    @carts = Cart.where(user: :current_user)
    date = DateTime.now
    dates = date.strftime('%Y-%m-%d %H:%M')
    @carts.each do |cart|
      @order = Order.new
      @order.product_id = cart.product_id
      @order.user_id = cart.user_id
      @order.quantity = cart.quantity
      @order.created_at = dates
      @order.save
      cart.delete
    end
  end

  def orderHistorys
    @orders = Order.where(status: true)
    @orders.each do |order|
      @orderHistory = OrderHistory.new
      @orderHistory.name = order.product.name
      @orderHistory.description = order.product.description
      @orderHistory.price = order.product.price
      @orderHistory.quantity = order.quantity
      @orderHistory.quantity = order.user_id
      @orderHistory.save
      order.delete
    end
  end

  def orderHistory
    @order = OrderHistory.where(user_id: current_user.id)
  end

  def orderConfirm
    @carts = Cart.where(['user_id= ?', current_user.id])
    @carts.each do |cart|
      @order = Order.new
      @order.product_id = cart.product_id
      @order.user_id = cart.user_id
      @order.quantity = cart.quantity
      @order.save
      cart.delete
    end
    @order = Order.where(['user_id= ?', current_user.id])
  end

  def deleteComment
    Comment.delete(params[:commentId])
  end

  def updateLike 
    if Like.exists?(comment_id: params[:commentId], user_id: params[:userId])
      like = Like.find_by(comment_id: params[:commentId], user_id: params[:userId])
      if like.likeValue
        like.update( likeValue: false )
      else
        like.update( likeValue: true )
      end
    else
      Like.create(comment_id: params[:commentId], user_id: params[:userId], likeValue: false)
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
