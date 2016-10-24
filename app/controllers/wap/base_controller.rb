class Wap::BaseController < ApplicationController

  layout 'wap'

  before_filter :current_user

  private
  def current_user
    User.first
  end
end