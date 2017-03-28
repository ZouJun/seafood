class Admin::StaffsController < Admin::BaseController

  before_filter :find_staff, only: [:edit, :update, :normal, :disabled]

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

  def create
    @staff = Staff.new(params[:staff])
    if @staff.save!
      SystemRecord.system_record('staff', @staff.id, '新增', current_staff.id, current_staff.role.name)
      redirect_to admin_staffs_path, notice: '添加成功'
    else
      redirect_to :back, alert: '添加失败'
    end
  end

  def edit
  end

  def update
    if @staff.update_attributes(params[:staff])
      SystemRecord.system_record('staff', @staff.id, '更新', current_staff.id, current_staff.role.name)
      redirect_to admin_staffs_url, notice: '操作成功'
    else
      redirect_to :back, alert: '操作失败'
    end
  end

  def import
    if Staff.import(params[:file])
      redirect_to :back, notice: '导入成功'
    else
      redirect_to :back, alert: '导入失败,请核对表格数据是否正确'
    end
  end

  def normal
    if @staff.normal!
      SystemRecord.system_record('staff',@staff.id,'解冻',current_staff.id, current_staff.role.name)
      redirect_to :back , notice:'操作成功'
    end
  end

  def disabled
    if @staff.disabled!
      SystemRecord.system_record('staff',@staff.id,'冻结',current_staff.id, current_staff.role.name)
      redirect_to :back , notice:'操作成功'
    end
  end

  def download
    send_file("#{Rails.root}/public/template/staff.csv")
  end

  private

  def find_staff
    @staff = Staff.find(params[:id])
  end

end