namespace :recreate_permission do
  desc 'created admins'
  task :recreate_permissions => :environment do
  	permission_list = {
  		1 => '员工列表',
  		2 => '部门(仓库)调动',
  		3 => '角色管理',
  		4 => '部门管理',
  		5 => '仓库录入',
  		6 => '商品录入',
  		7 => '出(入)库记录',
  		8 => '仓库数据分析',
  		9 => '商品录入',
  		10 => '系统日志'
  	}
    puts "Start create permission"
  	permission_list.each do |key, value|
  		permission = Permission.where(name: value).first_or_create
  		RolePermissionMap.where(role_id: 1, permission_id: permission.id).first_or_create
  	end
    puts "Finished"
  end
end