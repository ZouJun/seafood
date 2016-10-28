class Admin::MenusController < Admin::BaseController

  def index
    #@search = Category.normal.search(params[:search])
    @categories = Category.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_menus_path, notice: '添加成功'
    else
      render 'new'
    end
  end
end