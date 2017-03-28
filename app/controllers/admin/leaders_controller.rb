class Admin::LeadersController < Admin::BaseController

  before_filter :find_staff, only: [:normal, :disabled]

  def index
    @search = Staff.search(params[:search])
    @staffs = @search.page(params[:page])
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(params[:staff])
    if @staff.save
      SystemRecord.system_record('staff',@staff.id,'新增',current_account.id, '管理员')
      redirect_to admin_staffs_path, notice: '添加成功'
    else
      redirect_to :back, alert: '添加失败'
    end
  end

  def normal
    if @staff.normal!
      SystemRecord.system_record('staff',@staff.id,'解冻',current_account.id, '管理员')
      redirect_to :back , notice:'操作成功'
    end
  end

  def disabled
    if @staff.disabled!
      SystemRecord.system_record('staff',@staff.id,'冻结',current_account.id, '管理员')
      redirect_to :back , notice:'操作成功'
    end
  end

  private

  def find_staff
    @staff = Staff.find(params[:id])
  end

end