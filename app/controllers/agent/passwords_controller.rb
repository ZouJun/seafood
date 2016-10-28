class Agent::PasswordsController < Agent::BaseController

  def edit
    @agent = Agent.find(params[:id])
  end

  def update
    @agent = Agent.find(params[:id])
    if params[:agent][:current_password]
      if !@agent.authenticate(params[:agent][:current_password])
        return redirect_to :back, notice: '当前密码为空或不正确'
      elsif params[:agent][:password].blank?
        return redirect_to :back, notice: '新密码不能为空'
      elsif params[:agent][:password] != params[:agent][:password_confirmation]
        return redirect_to :back, notice: '前后输入密码不一致'
      end
    end

    if @agent.update_attributes(password: params[:agent][:password])
      clear_session_trace
      flash[:notice] = "修改成功,请使用新密码登陆"
      redirect_to sign_in_path
    else
      flash[:alert] = "当前用户或密码不正确!"
      render 'edit'
    end
  end
end