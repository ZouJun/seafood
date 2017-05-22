class Admin::BaseController < ApplicationController

  layout 'admin'
  before_filter :require_staff

  ##载入当前登陆用户
  private
  def require_staff
      if session[:staff_id]
         return true
      else
        redirect_to sign_in_url, notice: '请登录'
      end
  end
end