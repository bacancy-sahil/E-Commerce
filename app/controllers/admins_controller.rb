# frozen_string_literal: true

# AdminContoller.
class AdminsController < ApplicationController
  def index; end
  
  def approval
    @orders = Order.order(:user_id,:created_at)
  end

  def update_order_status
    orderId = params[:order_id]
    status = params[:status]
    user = params[:userId]
    if status=="2"
      @order = Order.find_by(["id = ? and user_id = ?", orderId, user]) 
      o=Order.find(orderId)
      quentity = o.product.quentity   
      quentity += o.quantity
      @product = Product.find(o.product.id)
      @product.update(:quentity=>quentity)  
      o.delete
    elsif status=="1"
    order = Order.find_by(["id = ? and user_id = ?", orderId, user]) 
    order.update(status:status)
    @order = Order.where(["status= ?", true])
    # NewsLetterMailer.order(@cart).deliver_now
    for o in @order.each
      @orderHistory = OrderHistory.new
      @orderHistory.name = o.product.name
      @orderHistory.description = o.product.description
      @orderHistory.price = o.product.price
      @orderHistory.quentity = o.quantity
      @orderHistory.user_id = o.user_id
      @orderHistory.save
      @order = Order.find(o.id)
      @order.delete
    end
    render json: {
      data: 'true'
    }
  end
  end

end
