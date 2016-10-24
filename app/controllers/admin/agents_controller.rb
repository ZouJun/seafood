class Admin::AgentsController < Admin::BaseController

  def index
    @agents = Agent.normal
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
end