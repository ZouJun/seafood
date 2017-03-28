class City < ActiveRecord::Base

	belongs_to :province
	has_many :districts
	has_many :staffs
	has_many :warehouses
end