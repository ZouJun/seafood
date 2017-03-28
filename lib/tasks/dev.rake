namespace :dev do
  desc 'created admins'
  task :create_admins => :environment do
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
  		10 => '商品数据分析',
  		11 => '系统日志'
  	}

  	Role.create!(name: '管理员', description: '最高权限拥有者')
  	permission_list.each do |key, value|
  		permission = Permission.create!(name: value)
  		RolePermissionMap.create!(role_id: 1, permission_id: permission.id)
  	end


    puts 'Starting create admins ******'
    staff = Staff.where(no: 'admin').first_or_create(name: '管理员', password: 111111, password_confirmation: 111111, mobile: 13899998888, email: 'foo@bar.com', role_id: 1)
    puts "created admin: #{staff.name}"
  end
end