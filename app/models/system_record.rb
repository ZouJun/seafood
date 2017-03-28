class SystemRecord < ActiveRecord::Base
	belongs_to :operatorable, polymorphic: true

	def self.system_record(object, object_id, action, operator_id, operator_type)
		case object
		when 'staff'
			staff = Staff.find(object_id)
			system_record = staff.system_records.build
			if system_record.update_attributes!(action: action, operator_id: operator_id, operator_type: operator_type)
				return true
			end
		when 'role'
			role = Role.find(object_id)
			system_record = role.system_records.build
			if system_record.update_attributes!(action: action, operator_id: operator_id, operator_type: operator_type)
				return true
			end
		when 'department'
			department = Department.find(object_id)
			system_record = department.system_records.build
			if system_record.update_attributes!(action: action, operator_id: operator_id, operator_type: operator_type)
				return true
			end
		when 'product'
			product = Product.find(object_id)
			system_record = product.system_records.build
			if system_record.update_attributes!(action: action, operator_id: operator_id, operator_type: operator_type)
				return true
			end
		when 'warehouse'
			warehouse = Warehouse.find(object_id)
			system_record = warehouse.system_records.build
			if system_record.update_attributes!(action: action, operator_id: operator_id, operator_type: operator_type)
				return true
			end
		else
			puts "aa"
		end
	end
end