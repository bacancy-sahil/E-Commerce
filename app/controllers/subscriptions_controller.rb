# frozen_string_literal: true

# SubscriptionsController
class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @subscription = Subscription.new
  end

  def index
    @subscription = Subscription.all
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to subscriptions_path
    else
      render 'new'
    end
  end

  def find
    @subscription = Subscription.find(params[:id])
  end

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update(subscription_params)
      redirect_to subscriptions_path
    else
      render 'edit'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end

  def subscription_params
    params.require(:subscription).permit(:description, :price, :status, :numberofproducts, :duration)
  end
end
