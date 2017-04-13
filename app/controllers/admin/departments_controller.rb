class Admin::DepartmentsController < Admin::BaseController

	def index
		@search = Department.where(status: [1, -1]).search(params[:search])
    @departments = @search.page(params[:page])
	end

	def new
   	 	@department = Department.new
  	end

  	def create
	   	@department = Department.new(params[:department])
	    if @department.save
        SystemRecord.system_record('department', @department.id, '新增', current_staff.id, current_staff.role.name)
	      redirect_to admin_departments_url, notice: '添加成功'
	    else
	      render 'new'
	    end
  	end

  	def edit
  		@department = Department.find(params[:id])
  	end

  	def update
  		@department = Department.find(params[:id])
  		if @department.update_attributes(params[:department])
        SystemRecord.system_record('department', @department.id, '更新', current_staff.id, current_staff.role.name)
  			redirect_to admin_departments_url, notice: '操作成功'
  		else
  			redirect_to :back, alert: '操作失败'
  		end
  	end

    def destroy
      @department = Department.find(params[:id])
      if @department.staffs.present?
        redirect_to :back, alert: '当前部门下存在员工，不能删除!'
      else
        SystemRecord.system_record('department', @department.id, '删除', current_staff.id, current_staff.role.name)
        @department.deleted!
        redirect_to admin_departments_url , notice: '删除成功'
      end
    end

  	def normal
	    @department = Department.find(params[:id])
	    if @department.normal!
	      redirect_to :back , notice:'操作成功'
	    end
  	end

  	def disabled
	    @department = Department.find(params[:id])
	    if @department.disabled!
	      redirect_to :back , notice:'操作成功'
	    end
  	end
end