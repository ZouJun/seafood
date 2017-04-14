class WarehouseRecord < ActiveRecord::Base

	belongs_to :warehouse
	belongs_to :staff
	belongs_to :product
	has_many :system_records, as: :operatorable

	acts_as_enum :record_type, :in => [
		['in', 1, '入库'],
		['out', 2, '出库']
	]
end