class Admin::WarehousesController < Admin::BaseController

	before_filter :find_warehouse, only: [:edit, :update, :normal, :disabled]

	def index
		if current_warehouse
			@warehouse = current_warehouse
		else
			@search = Warehouse.search(params[:search])
			@warehouses = @search.page(params[:page])
		end
	end

	def new
   	 	@warehouse = Warehouse.new
  	end

	def create
	   	@warehouse = Warehouse.new(params[:warehouse])
	    if @warehouse.save
	      SystemRecord.system_record('warehouse', @warehouse.id, '新增', current_staff.id, current_staff.role.name)
	      redirect_to admin_warehouses_path, notice: '添加成功'
	    else
	      render 'new'
	    end
	end

	def edit
	end

	def update
		if @warehouse.update_attributes(params[:warehouse])
      		SystemRecord.system_record('warehouse', @warehouse.id, '更新', current_staff.id, current_staff.role.name)
			redirect_to admin_warehouses_path, notice: '更新成功'
		else
			redirect_to :back, alert: '更新失败'
		end
	end

	def normal
	    if @warehouse.normal!
	      redirect_to :back , notice:'操作成功'
	    end
	end

	def disabled
	    if @warehouse.disabled!
	      redirect_to :back , notice:'操作成功'
	    end
	end

	private
		def find_warehouse
		    @warehouse = Warehouse.find(params[:id])
		end
end