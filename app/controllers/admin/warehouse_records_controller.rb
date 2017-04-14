class Admin::WarehouseRecordsController < Admin::BaseController

	def index
		if current_warehouse
			@search = WarehouseRecord.where(:id => current_warehouse.warehouse_records).search(params[:search])
			@warehouse_records = @search.page(params[:page])
		else
			@search = WarehouseRecord.search(params[:search])
	    	@warehouse_records = @search.page(params[:page])
		end
		respond_to do |format|
		      format.html
		      format.xls
	    end
	end

	def new
		if current_warehouse
			if Product.count < 1
				return redirect_to admin_products_path, notice: '请先去添加商品!'
			else
				@warehouse_record = current_staff.warehouse_records.build
			end
		else
			if Product.count < 1
				return redirect_to admin_products_path, notice: '请先去添加商品!'
			elsif Warehouse.count < 1
				return redirect_to admin_warehouses_path, notice: '请先去添加仓库!'
			else
		   	 	@warehouse_record = current_staff.warehouse_records.build
		   	end
	    end
  	end

  	def create
  		# binding.pry
		warehouse_product = WarehouseProduct.where(product_id: params[:warehouse_record][:product_id], warehouse_id: params[:warehouse_record][:warehouse_id]).first_or_create
		if params[:warehouse_record][:record_type].to_i == 1
			warehouse_product.update_attributes(qty: warehouse_product.qty + params[:warehouse_record][:qty].to_i, price: params[:warehouse_record][:price])
		else
			if warehouse_product.qty < params[:warehouse_record][:qty].to_i
				return redirect_to :back, alert: '该仓库未有足够对应的商品进行出库操作'
			else
				warehouse_product.update_attributes(qty: warehouse_product.qty - params[:warehouse_record][:qty].to_i, price: params[:warehouse_record][:price])
			end
		end	
	   	@warehouse_record = current_staff.warehouse_records.build(params[:warehouse_record])
	    if @warehouse_record.save
	      SystemRecord.system_record('warehouse_record', @warehouse_record.id, '新增', current_staff.id, current_staff.role.name)
	      redirect_to admin_warehouse_records_path, notice: '添加成功'
	    else
	      render 'new'
	    end
  	end

end