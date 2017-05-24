module ApplicationHelper

  ##左侧菜单栏是否展开判断
  def can?(ids)
      permission_ids = []
      current_staff.role.role_permission_maps.each do |t|
        permission_ids.push(t.permission.id)
      end 

      if permission_ids.include?(ids)
        true
      else
        false
      end
  end

  ##页面权限判断
  def page_can?
    permission_id = get_permissioin_no(params[:controller])
    if can?(permission_id)
      return true
    else
      render text: '无权访问!'
    end
  end

  def get_permissioin_no(controller)
    case controller
    when 'admin/staffs' then 1
    when 'admin/staff_transfers' then 2
    when 'admin/roles' then 3
    when 'admin/departments' then 4
    when 'admin/warehouses' then 5
    when 'admin/warehouse_products' then 6
    when 'admin/warehouse_records' then 7
    when 'admin/warehouse_records' then 8
    when 'admin/products' then 9
    when 'admin/system_records' then 10
    else
      11
    end
  end

  def current_staff
    if session[:staff_id]
       Staff.find(session[:staff_id])
    else
       redirect_to sign_in_url, notice: '请登录'
    end
  end

  def get_operator(operator_id, operator_type)
      Staff.find(operator_id).name
  end

  def get_operatorable(operatorable)
    case operatorable
    when 'Staff'
      '员工'
    when 'Department'
      '部门'
    when 'Role'
      '角色'
    when 'Product'
      '商品'
    when 'Warehouse'
      '仓库'
    when 'WarehouseRecord'
      '商品出入库'  
    else
      return '未知类型'
    end
  end

  def change_time
    dd = Time.now.wday
    case dd
    when 0 then '天'
    when 1 then '一'
    when 2 then '二'
    when 3 then '三'
    when 4 then '四'
    when 5 then '五'
    else
      '六'
    end
  end

  def random_back
    rand(2) == 0? 'session_body1' : 'session_body2'
  end
end
