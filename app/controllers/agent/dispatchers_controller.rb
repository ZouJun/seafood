class Agent::DispatchersController < Agent::BaseController

  def index
    #@search = current_agent.dispatchers.search(params[:search])
    @dispatchers = current_agent.dispatchers.page(params[:page])
  end

  def new
    @dispatcher = current_agent.dispatchers.new
  end

  def create
    @dispatcher = current_agent.dispatchers.new(params[:dispatcher])
    if @dispatcher.save
      redirect_to agent_dispatchers_path, notice: '添加成功'
    else
      render 'new'
    end
  end

  def normal
    @dispatcher = Dispatcher.find(params[:id])
    if @dispatcher.normal!
      redirect_to :back , notice:'操作成功'
    end
  end

  def disabled
    @dispatcher = Dispatcher.find(params[:id])
    if @dispatcher.disabled!
      redirect_to :back , notice:'操作成功'
    end
  end
end