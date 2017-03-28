class Admin::WarehouseRecordsController < Admin::BaseController

	def index
		@search = WarehouseRecord.search(params[:search])
    	@warehouse_records = @search.page(params[:page])
    	respond_to do |format|
	      format.html
	      format.xls
	    end
	end

	def new
		if Product.count < 1
			return redirect_to admin_products_path, notice: '请先去添加商品!'
		elsif Warehouse.count < 1
			return redirect_to admin_warehouses_path, notice: '请先去添加仓库!'
		else
	   	 	@warehouse_record = WarehouseRecord.new
	   	end
  	end

  	def create
	   	@warehouse_record = WarehouseRecord.new(params[:warehouse_record])
	   	@warehouse_record.staff_id = current_account.id
	    if @warehouse_record.save
	      SystemRecord.system_record('warehouse_record', @warehouse_record.id, '新增', current_account.id, '管理员')
	      redirect_to admin_warehouse_records_path, notice: '添加成功'
	    else
	      render 'new'
	    end
  	end

end