class WarehouseProduct < ActiveRecord::Base

	belongs_to :product
	belongs_to :warehouse
end