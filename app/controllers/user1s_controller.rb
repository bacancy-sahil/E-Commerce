class User1sController < ApplicationController
  before_action :authenticate_user! ,only:[:new,:create,:cart]
  def new
    @user =User.new
    @brand = @user.build_brand
  end

  def create
    @user = User.new
    @brand = Brand.new
    @user.email=params[:user][:email]
    @user.password = params[:user][:password]
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

  def home
    @category = Category.where(status:true)
    @product = Product.where(status:true)
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
              return redirect_to user1s_cart_path 
            end
        else
         
          flash[:notice]="Product " + productName+ " out of stock."        
         return redirect_to user1s_cart_path
        end
    end
    return redirect_to 'user1s/orderConfirm'
  end

  def updateCartValue
    productId = params[:productId];
    quentity = params[:quentity];
    Cart.where(user_id: current_user.id,product_id: productId).update(quentity: quentity);
    puts "done"
  end

  def orderConfirm
   @cart = Cart.where(["user_id= ?", current_user.id])
  end









  def set_params
    params.require(:user).permit(:email, :password, brand_attributes: [:subscription_id,:name])
  end

  
end
