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


















  def set_params
    params.require(:user).permit(:email, :password, brand_attributes: [:subscription_id,:name])
  end

  
end
