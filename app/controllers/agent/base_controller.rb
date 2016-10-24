class Agent::BaseController < ApplicationController

  layout 'admin'
  before_filter :current_agent

  private
  def current_agent
    if session[:agent_id]
      Agent.find(session[:agent_id])
    else
      redirect_to sign_in_url, notice: '请登录'
    end
  end
end