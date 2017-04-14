class ApplicationController < ActionController::Base
  protect_from_forgery

  include ApplicationHelper

  before_filter :page_can?

  helper_method :current_warehouse
  
  def clear_session_trace
	  session[:staff_id] = nil
  end

  def current_warehouse
  	Warehouse.find(session[:warehouse_id]) if session[:warehouse_id]
  end
end
