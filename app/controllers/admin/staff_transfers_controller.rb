class Admin::StaffTransfersController < Admin::BaseController

	def index
		@search = StaffTransfer.search(params[:search])
    	@staff_transfers = @search.page(params[:page])
	end

	def new
		@staff_transfer = StaffTransfer.new
		@staff = Staff.find(params[:staff_id])
	end

	def create
		@staff = Staff.find(params[:staff_id])
		@staff_transfer = StaffTransfer.new
		@staff_transfer.staff_id = @staff.id
		@staff_transfer.operator_id = current_staff.id
		# binding.pry
		if params[:staff_transfer][:role_id].blank?
			@staff_transfer.role_id = @staff.role_id
		else
			@staff_transfer.role_id = params[:staff_transfer][:role_id].to_i
		end
		if session[:admin_id]
			@staff_transfer.operator_type = 'admin'
		else
			@staff_transfer.operator_type = 'staff'
		end

		if params[:is_department] == 'on'
			if @staff.department_id == params[:staff_transfer][:department_id].to_i
				redirect_to :back, notice: '部门调动前后必须不一致!'
				return
			else
				@staff_transfer.is_department = 1
				@staff_transfer.before_department_id = @staff.department_id
				@staff_transfer.department_id = params[:staff_transfer][:department_id]
				@staff.update_attributes(department_id: params[:staff_transfer][:department_id].to_i)
			end
		end
		
		if params[:is_warehouse] == 'on'
			if @staff.warehouse_id.present? && @staff.warehouse_id == params[:staff_transfer][:warehouse_id].to_i
				redirect_to :back, notice: '仓库调动前后必须不一致!'
				return
			else
				@staff_transfer.is_warehouse = 1
				@staff_transfer.before_warehouse_id = @staff.warehouse_id
				@staff_transfer.warehouse_id = params[:staff_transfer][:warehouse_id]
				@staff.update_attributes(warehouse_id: params[:staff_transfer][:warehouse_id].to_i)
			end
		end

		if @staff_transfer.save!
			if params[:staff_transfer][:role_id].present?
				@staff.update_attributes(role_id: params[:staff_transfer][:role_id].to_i)
			end
			SystemRecord.system_record('staff_transfer', @staff_transfer.id, '仓库(部门)调动', current_staff.id, '管理员')
			redirect_to admin_staff_transfers_url, notice: '操作成功'
		else
			redirect_to :back, notice: '操作失败'
		end
	end


	def position
		@search = Leader.search(params[:search])
    	@leaders = @search.page(params[:page])
	end
end