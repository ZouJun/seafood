class Admin::BookingsController < Admin::BaseController

  before_filter :find_order, only: [:show, :update, :auto, :cancel]

  def index
    #@search = Order.search(params[:search])
    @bookings = Order.order('created_at DESC').page(params[:page])
  end

  def update
    @order.admin_assigned!
    @order.admin_non_auto!
    @order.order_status = '后台管理员已分配好你的预约订单。'
    if @order.update_attributes(params[:order])
      redirect_to admin_bookings_path, notice: '分配成功'
    end
  end

  def auto
    @life_agent = Agent.normal.life.first
    @service_agent = Agent.normal.service.first
    if @order.category.life?
      if @life_agent.present?
        @order.update_attributes(agent_id: @life_agent.id, admin_status: Order::ADMIN_ASSIGNED,
                                 admin_allocation_type: Order::ADMIN_AUTO, order_status: '后台管理员已分配好你的预约订单。')
        redirect_to :back, notice: '自动分配成功'
      else
        redirect_to :back, alert: '请先去添加相应的代理商！'
      end
    else
      if @service_agent.present?
        @order.update_attributes(agent_id: @service_agent.id, admin_status: Order::ADMIN_ASSIGNED,
                                 admin_allocation_type: Order::ADMIN_AUTO, order_status: '后台管理员已分配好你的预约订单。')
        redirect_to :back, notice: '自动分配成功'
      else
        redirect_to :back, alert: '请先去添加相应的代理商！'
      end
    end
  end

  def cancel
    if @order.admin_cancel!
      @order.admin_non_auto!
      redirect_to :back, notice: '操作成功'
    end
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end
end