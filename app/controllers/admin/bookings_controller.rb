class Admin::BookingsController < Admin::BaseController

  def index
    @bookings = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.assigned!
    if @order.update_attributes(params[:order])
      redirect_to admin_bookings_path, notice: '分配成功'
    end
  end
end