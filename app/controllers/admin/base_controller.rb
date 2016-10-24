class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :require_account

  private
  def require_account
      if session[:account_id]
         return true
      else
        redirect_to sign_in_url, notice: '请登录'
      end
  end

end