class OrdersController < ApplicationController
  helper_method :order

  def new
    @order = Order.new date: Time.now
  end

  def index
    @orders = Order.includes(:customer).order(updated_at: :desc).all
  end

  def create
    @order = Order.new order_params
    if order.save
      flash.notice = "Order #{order.number} has been created!"
      redirect_to order_path(order.id)
    else
      flash.alert = 'There was a problem creating an Order'
      render :new
    end
  end

  def update
    if order.update order_params
      flash.notice = "Order #{order.number} has been updated!"
      redirect_to  orders_path
    else
      flash.alert = 'There was a problem updating the Order'
      render :edit
    end
  end

  def destroy
    order_number = order.number
    if order.destroy
      flash.notice = "Order #{order_number} has been deleted!"
      redirect_to orders_path
    else
      flash.alert = 'There was a problem deleting the Order'
      render :edit
    end
  end

  private

  def order
    @order ||= Order.find params[:id]
  end

  def order_params
    params.require(:order).
      permit :number, :date, :customer_id
  end
end
