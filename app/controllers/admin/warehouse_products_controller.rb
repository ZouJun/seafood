class Admin::WarehouseProductsController < Admin::BaseController

	def index
		@search = WarehouseProduct.search(params[:search])
    	@warehouse_products = @search.page(params[:page])
	end

	def new
		if Product.count < 1
			return redirect_to admin_products_url, notice: '请先添加商品!'
		else
	   	 	@warehouse_product = WarehouseProduct.new
	   	end
  	end

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