class Admin::PasswordsController < Admin::BaseController
  skip_before_filter :page_can?

  def create
    if current_staff.update_attributes(params[:staff])
      redirect_to admin_home_url, notice: '修改成功'
    else
      redirect_to :back, alert: '修改失败'
    end
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  ##更新密码
  def update
    @staff = Staff.find(params[:id])
    if params[:staff][:current_password]
      if !@staff.authenticate(params[:staff][:current_password])
        return redirect_to :back, notice: '旧密码为空或不正确'
      elsif params[:staff][:password].blank?
        return redirect_to :back, notice: '新密码不能为空'
      elsif params[:staff][:password] != params[:staff][:password_confirmation]
        return redirect_to :back, notice: '前后输入密码不一致'
      elsif params[:staff][:current_password] == params[:staff][:password]
        return redirect_to :back, notice: '新密码与旧密码必须不一致'
      end
    end

    if @staff.update_attributes(password: params[:staff][:password])
      clear_session_trace
      flash[:notice] = "修改成功,请使用新密码登陆"
      redirect_to sign_in_path
    else
      flash[:alert] = "当前用户或密码不正确!"
      render 'edit'
    end
  end
end