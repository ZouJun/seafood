class ApplicationController < ActionController::Base
  protect_from_forgery

  def clear_session_trace
    if session[:account_id]
      session[:account_id] = nil
    else
      session[:agent_id] = nil
    end
  end
end
