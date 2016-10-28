class Wap::BaseController < ApplicationController

  layout 'wap'

  before_filter :current_user

  private
  def current_user
    @user = User.first
    session[:user_id] = @user.id
    @user
  end
end