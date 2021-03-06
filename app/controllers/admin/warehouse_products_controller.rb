class Admin::WarehouseProductsController < Admin::BaseController

	##仓库产品列表
	def index
		if current_warehouse
			@search = WarehouseProduct.where(:id => current_warehouse.warehouse_products).search(params[:search])
			@warehouse_products = @search.page(params[:page])
		else
			@search = WarehouseProduct.search(params[:search])
	    	@warehouse_products = @search.page(params[:page])
	    end
	end

	def new
		if Product.count < 1
			return redirect_to admin_products_url, notice: '请先添加商品!'
		else
	   	 	@warehouse_product = WarehouseProduct.new
	   	end
  	end

  	##新建仓库产品
  	def create
	   	@warehouse_product = WarehouseProduct.new(params[:warehouse_product])
	    if @warehouse_product.save
	      SystemRecord.system_record('warehouse_product', @warehouse_product.id, '新增', current_staff.id, current_staff.role.name)
	      redirect_to admin_warehouse_products_path, notice: '添加成功'
	    else
	      render 'new', alert: '保存失败，请核对数据的正确性'
	    end
	end
end