class Admin::StaffsController < Admin::BaseController

  before_filter :find_staff, only: [:edit, :update, :normal, :disabled]

  ##员工列表数据
  def index
    @search = Staff.search(params[:search])
    @staffs = @search.page(params[:page])

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @staff = Staff.new
  end

  ##新增员工
  def create

    @staff = Staff.new(params[:staff])
    if @staff.save! ##保存员工
      ##如果分配仓库，就直接保存。未分仓库，则设置为ALL
      if params[:staff][:warehouse_id].blank? && @staff.department_id == 4
        @staff.update_attributes(warehouse_id: 0)
      end
      ##系统日志记录
      SystemRecord.system_record('staff', @staff.id, '新增', current_staff.id, current_staff.role.name)
      ##保存成功后，进行跳转
      redirect_to admin_staffs_path, notice: '添加成功'
    else
      redirect_to :back, alert: '添加失败'
    end
  end

  def edit
  end

  ##修改员工信息
  def update
    ##修改员工信息
    if @staff.update_attributes(params[:staff])
      ##系统日志
      SystemRecord.system_record('staff', @staff.id, '更新', current_staff.id, current_staff.role.name)
      ##操作成功，进行跳转
      redirect_to admin_staffs_url, notice: '操作成功'
    else
      redirect_to :back, alert: '操作失败'
    end
  end

  ##导入员工信息
  def import
    if Staff.import(params[:file])
      redirect_to :back, notice: '导入成功'
    else
      redirect_to :back, alert: '导入失败,请核对表格数据是否正确'
    end
  end

  ##对员工进行解冻
  def normal
    ##解冻账号
    if @staff.normal!

      SystemRecord.system_record('staff',@staff.id,'解冻',current_staff.id, current_staff.role.name)

      redirect_to :back , notice:'操作成功'
    end
  end

  ##对员工进行冻结
  def disabled
    if @staff.disabled!
      # @staff.update_attributes(status: -1)
      SystemRecord.system_record('staff',@staff.id,'冻结',current_staff.id, current_staff.role.name)
      redirect_to :back , notice:'操作成功'
    end
  end

  ##下载导入模板
  def download
    send_file("#{Rails.root}/public/template/staff.csv")
  end

  private

  def find_staff
    @staff = Staff.find(params[:id])
  end

end