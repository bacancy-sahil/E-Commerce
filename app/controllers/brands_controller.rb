# frozen_string_literal: true

# BrandContoller.
class BrandsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :done]

  def new
    @user = User.new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.subscription_id = params[:subscription_id]
    @brand.save
  end

  def update
    @brand = Brand.find(params[:id])

    if (params[:brand][:status] == "1" and params[:brand][:startingdate] == nil)
      d = DateTime.now
      @brand.startingdate = d.strftime("%Y-%m-%d %H:%M:%S")
      duration = @brand.subscription.duration
      addMonths = d + duration.months
      @brand.endingdate = addMonths.strftime("%Y-%m-%d %H:%M:%S")
      @brand.user.remove_role :user
      @brand.user.has_role? :brand
      NewsLetterMailer.sendCongratulations(@brand).deliver_now
    end
    if (params[:brand][:status] == "0")
      @brand.startingdate = nil
      @brand.endingdate = nil
    end
    if @brand.update!(brand_params)
      redirect_to brands_path
    else
      render :edit
    end
  end

  def done
  end

  def status
    @brand = Brand.where(status: 0)
  end

  def index
    @brand = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    NewsLetterMailer.sendDelete(@brand).deliver_now

    redirect_to brands_path
  end

  def brand_params
    params.require(:brand).permit(:subscription_id, :email, :password, :name, :status)
  end

  def subscription
    @brand = Brand.joins(:user).select("users.*, brands.*")
  end
end
