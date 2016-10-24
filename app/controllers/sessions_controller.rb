class SessionsController < ApplicationController

  def create
    if params[:login_type].to_i == 1
      if account = Account.authenticated(params[:login], params[:password])
        session[:account_id] = account.id
        redirect_to admin_agents_path, notice: '登陆成功'
      end
    else
      if agent = Agent.authenticated(params[:login], params[:password])
        session[:agent_id] = agent.id
        redirect_to agent_bookings_path, notice: '登陆成功'
      end
    end
  end

  def destroy
    if session[:account_id]
    session[:account_id] = nil
    end
    if session[:agent_id]
      session[:agent_id] = nil
    end
    redirect_to sign_in_url
  end
end