# frozen_string_literal: true

# clientController
class ClientController < ApplicationController
  before_action :authenticate_user! ,only:[:new,:create,:cart,:order]
  def new
    @user =User.new
    @brand = @user.build_brand
  end

  def create
    @user = User.new
    @brand = Brand.new
    @user.email=params[:user][:email]
    @user.password = params[:user][:password]
    NewsLetterMailer.sendmail(@user).deliver_now
    if @user.save!
      @brand.subscription_id = params[:user][:brand][:subscription_id]
      @brand.name = params[:user][:brand][:name]
      @brand.user_id = @user.id
      @brand.save
      @user.add_role :brand
      redirect_to brands_path
    else
      redirect_to brands_path
    end
  end

  def category
   @product = Product.where(category_id:params[:id])
 end

 def addComment
  product_id=params[:productId]
  user_id=params[:customerId]
  description=params[:description]
  Comment.create(:product_id=>params[:productId],:user_id=>params[:customerId],:description=>params[:description])
end

def subCategory
  subCategoryId = params[:id]
  @product = Product.where(sub_category_id:subCategoryId)
end


def updateComment  
  c = Comment.find(params[:commentId]) 
  c.update(:description=>params[:description])
end

def brand
  brandId = params[:id];
  @product = Product.where(brand_id:brandId)
end

def product
  @product = Product.find(params[:id])
  if(user_signed_in?)
    if(Mappingtable.exists?(:user_id=>current_user.id,:product_id=>params[:id]))
    else
      @map = Mappingtable.new()
      @map.product_id=params[:id];
      @map.user_id = current_user.id;
      @map.save
    end
  end
end

def AddToCart 
  productId=params[:productId];
  @cart=Cart.new
  @cart.user_id = current_user.id
  @cart.product_id = params[:productId]
  @cart.quentity = 1
  @cart.save
  redirect_to :action => "cart"
end

def cart
  @cart = Cart.where(["user_id= ?", current_user.id])
end


def orderConfirm
  @cart = Cart.where(["user_id= ?", current_user.id])
end

def home
  @category = Category.where(status:true)
  @product = Product.where(status:true)
  @products = Product.order('created_at DESC').take(3)
end

def deleteCart
  @cart = Cart.find(params[:id])
  @cart.delete
  redirect_to :action => "cart"
end


def checkout
  @cart = Cart.where(user_id:current_user.id) 
  for c in @cart.each do   
   productQuentity = c.product.quentity
   productName = c.product.name
   cartQuentity = c.quentity
   if productQuentity > 0
    if productQuentity >= cartQuentity
      a= productQuentity - cartQuentity
      c.product.update(quentity:a)
    else
      flash[:notice]="You can add only " + productQuentity.to_s + " Quentity of this " + productName+"."
      return redirect_to client_cart_path 
    end
  else
    flash[:notice]="Product " + productName + " out of stock."        
    return redirect_to client_cart_path
  end
end
@order = Cart.where(["user_id= ?", current_user.id])
end

def updateCartValue
  productId = params[:productId];
  quentity = params[:quentity];
  Cart.where(user_id: current_user.id,product_id: productId).update(quentity: quentity);
  puts "done"
end

def orderHistorys
  @cart = Cart.where(["user_id= ?", current_user.id])
  for c in @cart.each do
    @orderHistory = OrderHistory.new
    @orderHistory.name = c.product.name
    @orderHistory.description =c.product.description
    @orderHistory.price = c.product.price
    @orderHistory.quentity = c.quentity
    @orderHistory.save
    @cart1 = Cart.find(c.id)
    @cart1.delete
  end

end


def orderHistory
  @order =OrderHistory.group(:created_at)
end

def orderConfirm
 @cart = Cart.where(["user_id= ?", current_user.id])
end


def deleteComment
  comment =  params[:commentId];
  Comment.delete(comment)
end

def updateLike
  commentId=params[:commentId]
  userId = params[:userId]
  if (Like.exists?(comment_id: commentId,user_id: userId)) 
    like = Like.find_by(comment_id: commentId,user_id: userId)
    if(like.likeValue)
      like.update(likeValue: false)
    else
      like.update(likeValue: true)
    end
  else
    Like.create(comment_id: commentId,user_id: userId)
  end
  render json: {
    data: 'true'
  }
end


def set_params
  params.require(:user).permit(:email, :password, brand_attributes: [:subscription_id,:name])
end


end
