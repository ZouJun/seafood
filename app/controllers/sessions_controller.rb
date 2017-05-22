class SessionsController < ApplicationController
  skip_before_filter :page_can?
  layout 'application'

  def new
  end

  ##用户登陆操作方法
  def create
    staff = Staff.authenticated(params[:login], params[:password])
    if staff
      if staff.normal?
        if staff.role.role_permission_maps.blank?
          return redirect_to :back, notice: '您还没有进入系统的权限!'
        else
          if staff.warehouse_id && staff.warehouse_id != 0
            session[:warehouse_id] = staff.warehouse_id
          end
          session[:staff_id] = staff.id
          staff.update_login_info(request.remote_ip)
          redirect_to admin_home_url, notice: '登陆成功!'
        end
      else
        return redirect_to :back, notice: '账号已被冻结，请联系相关部门人员进行解冻操作!'
      end
    else
      return redirect_to :back, notice: '账号或密码错误!'
    end
  end

  ##用户退出登陆操作方法
  def destroy
    if session[:staff_id]
      session[:staff_id] = nil
    end
    if session[:warehouse_id]
      session[:warehouse_id] = nil
    end
    current_staff.update_login_out
    redirect_to sign_in_url
  end
end