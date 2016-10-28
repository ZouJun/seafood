class Admin::AgentsController < Admin::BaseController

  def index
    @search = Agent.search(params[:search])
    @agents = @search.page(params[:page])
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(params[:agent])
    if @agent.save
      redirect_to admin_agents_path, notice: '添加成功'
    else
      render 'new'
    end
  end

  def normal
    @agent = Agent.find(params[:id])
    if @agent.normal!
      redirect_to :back , notice:'操作成功'
    end
  end

  def disabled
    @agent = Agent.find(params[:id])
    if @agent.disabled!
      redirect_to :back , notice:'操作成功'
    end
  end
end