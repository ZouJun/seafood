class Wap::AppliesController < Wap::BaseController
  before_filter :find_category, only: [:ordering]

  def index
    @categories = Category.normal
  end

  def ordering
    order
  end

  private
  def find_category
    @category = Category.where(id: params[:category_id]).first
  end

  def order
    @order = Order.new(
        description: '这是新的预约，请及时处理',
        category_id: @category.id,
        user_id: current_user.id
    )
    if @order.save
      redirect_to wap_applies_url ,notice: '预约成功'
    end
  end
end