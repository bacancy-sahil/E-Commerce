# frozen_string_literal: true

# clientController
class ClientController < ApplicationController
  before_action :authenticate_user!, only: %i[new cart order]

  def new
    @user = User.new
    @brand = @user.build_brand
  end

  def filterdatabyCat
    category=params[:catValue].to_i
    @product=Product.where("name LIKE :name1 AND category_id = :catid",{:name1 => "#{params[:catInput]}%", :catid => category})
  end

  def filterdata
    data=params[:filter]
    if data=='Sorting A to Z'
      @product = Product.order(name: :asc)
    elsif data=='Sorting Z to A'
      @product = Product.order(name: :desc)
    elsif data=='Sorting Price High to Low'
      @product = Product.order(price: :desc)
    elsif data=='Sorting Price Low to High'
      @product = Product.order(price: :asc)
    else
      @product = Product.all
    end
  end

  def search
    data = params[:data]
    @product = Product.search(data)
    # @category = Category.where(status: true)
    # @products = Product.order("created_at DESC").take(3)
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
    @product = Product.where(category_id: params[:id])
  end

  def addComment
    product_id = params[:productId]
    user_id = params[:customerId]
    description = params[:description]
    Comment.create(product_id: params[:productId], user_id: params[:customerId], description: params[:description])
  end

  def subCategory
    subCategoryId = params[:id]
    @product = Product.where(sub_category_id: subCategoryId)
  end

  def updateComment
    c = Comment.find(params[:commentId])
    c.update(description: params[:description])
    binding.pry
  end

  def brand
    brandId = params[:id]
    @product = Product.where(brand_id: brandId)
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
    @cart = Cart.where(["user_id= ?", current_user.id])
  end

  def orderConfirm
    @cart = Cart.where(["user_id= ?", current_user.id])
  end

  def home
    @category = Category.where(status: true)
    @product = Product.where(status: true)
    @products = Product.order("created_at DESC").take(3)
  end



  def deleteCart
    @cart = Cart.find(params[:id])
    @cart.delete
    redirect_to action: "cart"
  end

  def checkout
    @cart = Cart.where(user_id: current_user.id)
    for c in @cart.each
      productQuentity = c.product.quentity
      productName = c.product.name
      cartQuentity = c.quentity
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
    for c in @cart.each
      productQuentity = c.product.quentity
      productName = c.product.name
      cartQuentity = c.quentity
      a = productQuentity - cartQuentity
      c.product.update(quentity: a)
    end
    @order = Cart.where(["user_id= ?", current_user.id])
    order()
  end

  def updateCartValue
    productId = params[:productId]
    quentity = params[:quentity]
    Cart.where(user_id: current_user.id, product_id: productId).update(quentity: quentity)
    puts "done"
  end

  def order
    @cart = Cart.where(["user_id= ?", current_user.id])
    # NewsLetterMailer.order(@cart).deliver_now
    d=DateTime.now
    dates=d.strftime("%Y-%m-%d %H:%M")
    for c in @cart.each
      @order = Order.new
      @order.product_id = c.product_id
      @order.user_id = c.user_id
      @order.quantity = c.quentity
      @order.created_at = dates
      @order.save
      @cart1 = Cart.find(c.id)
      @cart1.delete
    end
  end

  def orderHistorys
    @order = Order.where(["status= ?", true])
    # NewsLetterMailer.order(@cart).deliver_now
    for o in @order.each
      @orderHistory = OrderHistory.new
      @orderHistory.name = o.product.name
      @orderHistory.description = o.product.description
      @orderHistory.price = o.product.price
      @orderHistory.quantity = o.quentity
      @orderHistory.quantity = o.user_id
      @orderHistory.save
      @order = Orer.find(o.id)
      @order.delete
    end
  end

  def orderHistory
    @order = OrderHistory.where(user_id:current_user.id)
  end

  def orderConfirm
    @cart = Cart.where(["user_id= ?", current_user.id]) 
    for c in @cart.each
      @order = Order.new
      @order.product_id = c.product_id
      @order.user_id = c.user_id
      @order.quantity = c.quentity
      @order.save
      @cart1 = Cart.find(c.id)
      @cart1.delete
    end
    @order = Order.where(["user_id= ?", current_user.id])
  end

  def deleteComment
    comment = params[:commentId]
    Comment.delete(comment)
    # Like.delete.where(comment_id: comment)
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
