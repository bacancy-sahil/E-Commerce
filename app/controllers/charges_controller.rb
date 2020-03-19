# frozen_string_literal: true

class ChargesController < ApplicationController
  def new
    @data = Pendingpayment.where('user_id=?', current_user.id).sum(:price)
  end

  def create
    @data = Pendingpayment.where('user_id=?', current_user.id).sum(:price)
    @amount = @data
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @data,
      description: 'Rails Stripe customer',
      currency: 'inr'
    )
    @orders = Pendingpayment.where('user_id = ?', current_user.id)
    @orders.each do |order|
      @orderHistory = OrderHistory.new
      @orderHistory.name = order.name
      @orderHistory.description = order.description
      @orderHistory.price = order.price
      @orderHistory.quantity = order.quantity
      @orderHistory.user_id = order.user_id
      @orderHistory.save
      @pendingpayment = Pendingpayment.find(order.id)
      @pendingpayment.delete
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
