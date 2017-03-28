class Admin::RolesController < Admin::BaseController

	def index
		@search = Role.search(params[:search])
    @roles = @search.page(params[:page])
	end

	def new
   	 @role = Role.new
  end

	def create
   	@role = Role.new(params[:role])
    if @role.save
      if params[:permission][:permission_ids].present?
        params[:permission][:permission_ids].each do |t|
          RolePermissionMap.create!(
            role_id: @role.id,
            permission_id: t.to_i
            )
        end
      end
      SystemRecord.system_record('role', @role.id, '新增', current_staff.id, current_staff.role.name)
      redirect_to admin_roles_path, notice: '添加成功'
    else
      render 'new'
    end
	end

	def edit
		@role = Role.find(params[:id])
	end

	def update
		@role = Role.find(params[:id])
		if @role.update_attributes(params[:role])
      if params[:permission][:permission_ids].present?
        @role.role_permission_maps.each do |t|
          t.destroy
        end

        params[:permission][:permission_ids].each do |m|
           RolePermissionMap.create!(
            role_id: @role.id,
            permission_id: m.to_i
            )
        end
      end
      SystemRecord.system_record('role', @role.id, '更新', current_staff.id, current_staff.role.name)
			redirect_to admin_roles_url, notice: '更新成功'
		else
			redirect_to :back, alert: '更新失败'
		end
	end

  def edit_role
    @staff = Staff.find(params[:staff_id])
    @staff_role_map = @staff.staff_role_maps.build
  end

  def update_role
    @staff = Staff.find(params[:staff_id])
    @staff_role_map = @staff.staff_role_maps.build
    @leader = @staff.leaders.build

    @staff_role_map_data = StaffRoleMap.where(staff_id: @staff.id, role_id: params[:role][:id].to_i)

    if @staff_role_map_data.present?
      redirect_to :back, alert: '该角色已有对应的角色名称'
    else 
      if @staff_role_map.update_attributes!(role_id: params[:role][:id]) && @leader.update_attributes!(login: params[:login], password: params[:password], role_id: params[:role][:id])
        SystemRecord.system_record('staff', @staff.id, '编辑人员角色', current_account.id, '管理员')
        redirect_to :back, notice: '操作成功'
      else
        redirect_to :back, alert: '操作失败'
      end
    end
  end

  def list
    @search = StaffRoleMap.search(params[:search])
    @staff_role_maps = @search.page(params[:page])
  end



	def normal
    @role = Role.find(params[:id])
    if @role.normal!
      redirect_to :back , notice:'操作成功'
    end
	end

	def disabled
    @role = Role.find(params[:id])
    if @role.disabled!
      redirect_to :back , notice:'操作成功'
    end
	end
end