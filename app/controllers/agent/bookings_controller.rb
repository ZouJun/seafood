class Agent::BookingsController < Agent::BaseController

  before_filter :find_order, only: [:show, :update, :auto, :cancel]

  def index
    #@search = current_agent.orders.search(params[:search])
    @bookings = current_agent.orders.page(params[:page])
  end

  def update
    @order.agent_assigned!
    @order.agent_non_auto!
    @order.order_status = '后台管理员已分配好您的预约订单。代理商已分配好您的预约订单。'
    if @order.update_attributes(params[:order])
      redirect_to agent_bookings_path, notice: '分配成功'
    end
  end

  def auto
    @dispatcher = Dispatcher.first
    if @dispatcher.present?
      if @order.update_attributes(dispatcher_id: @dispatcher.id, agent_status: Order::AGENT_ASSIGNED,
                                  agent_allocation_type: Order::AGENT_AUTO, order_status: '后台管理员已分配好您的预约订单。代理商已分配好您的预约订单。')
        redirect_to :back, notice: '自动分配成功'
      end
    else
      redirect_to :back, alert: '请先去添加对应的派送员'
    end
  end

  def cancel
    if @order.agent_cancel!
      @order.agent_non_auto!
      redirect_to :back, notice: '操作成功'
    end
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end
end