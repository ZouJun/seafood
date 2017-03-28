class Admin::ProductsController < Admin::BaseController

	def index
		@search = Product.search(params[:search])
    	@products = @search.page(params[:page])

    	respond_to do |format|
	      format.html
	      format.xls
	    end
	end

	def new
   	 	@product = Product.new
  	end

  	def create
	   	@product = Product.new(params[:product])

	    if @product.save
	      SystemRecord.system_record('product', @product.id, '新增', current_staff.id, current_staff.role.name)
	      redirect_to admin_products_path, notice: '添加成功'
	    else
	      render 'new'
	    end
  	end

  	def import
	  	if Product.import(params[:file])
	      redirect_to :back, notice: '导入成功'
	    else
	      redirect_to :back, alert: '导入失败,请核对表格数据是否正确'
	    end
	end

  	def normal
	    @product = Product.find(params[:id])
	    if @product.normal!
	      redirect_to :back , notice:'操作成功'
	    end
  	end

  	def disabled
	    @product = Product.find(params[:id])
	    if @product.disabled!
	      redirect_to :back , notice:'操作成功'
	    end
  	end

  	def download
  		send_file("#{Rails.root}/public/template/product.csv")
  	end
end