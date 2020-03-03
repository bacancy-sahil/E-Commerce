class User1sController < ApplicationController
  before_action :authenticate_user! ,only:[:new,:create]
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
    

  end


  def home
    @category = Category.where(status:true)
    @product = Product.where(status:true)
  end


















  def set_params
    params.require(:user).permit(:email, :password, brand_attributes: [:subscription_id,:name])
  end

  
end
