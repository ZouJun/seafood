class Province < ActiveRecord::Base
	has_many :cities
	has_many :staffs
	has_many :warehouses
end