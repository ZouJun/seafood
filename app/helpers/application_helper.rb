module ApplicationHelper

  def current_account
    if session[:account_id]
      Account.find(session[:account_id])
    else
      Agent.find(session[:agent_id])
    end
  end

  def current_user
    User.find(session[:user_id])
  end
end
