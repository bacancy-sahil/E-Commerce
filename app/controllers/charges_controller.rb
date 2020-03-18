class ChargesController < ApplicationController

  def new 
    @data = Pendingpayment.where('user_id=?',current_user.id).sum(:price)
  end

  def create
    @data = Pendingpayment.where('user_id=?',current_user.id).sum(:price)
    # Amount in cents
    @amount = @data

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @data,
      description: 'Rails Stripe customer',
      currency: 'inr',
    })

    @order = Pendingpayment.where('user_id=?',current_user.id)
    for o in @order.each
      @orderHistory = OrderHistory.new
      @orderHistory.name = o.name
      @orderHistory.description = o.description
      @orderHistory.price = o.price
      @orderHistory.quentity = o.quentity
      @orderHistory.user_id = o.user_id
      @orderHistory.save
      @pendingpayment = Pendingpayment.find(o.id)
      @pendingpayment.delete
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
