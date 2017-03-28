class District < ActiveRecord::Base
	belongs_to :city
	has_many :staffs
	has_many :warehouses
end