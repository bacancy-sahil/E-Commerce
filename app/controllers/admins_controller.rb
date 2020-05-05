# frozen_string_literal: true

# AdminContoller.
class AdminsController < ApplicationController
  def index; end

  def approval
    @orders = Order.order(:user_id, :created_at)
  end

  def update_order_status
    orderId = params[:order_id]
    status = params[:status]
    user = params[:userId]
    if status == '2'
      @order =  Order.find_by(['id = ? and user_id = ?', orderId, user])
      order = Order.find(orderId)
      quantity = order.product.quantity
      quantity += order.quantity
      @product = Product.find(order.product.id)
      @product.update(quantity: quantity)
      order.delete
    elsif status == '1'
      order =  Order.find_by(['id = ? and user_id = ?', orderId, user])
      order.update(status: status)
      @orders = Order.where(status: true)
      # NewsLetterMailer.order(@cart).deliver_now
      @orders.each do |order|
        @pendingpayment = Pendingpayment.new
        @pendingpayment.name = order.product.name
        @pendingpayment.description = order.product.description
        @pendingpayment.price = order.product.price
        @pendingpayment.quantity = order.quantity
        @pendingpayment.user_id = order.user_id
        @pendingpayment.save
        @order = Order.find(order.id)
        @order.delete
      end
      render json: {
        data: true
      }
    end
  end
end
