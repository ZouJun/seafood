class StaffTransfer < ActiveRecord::Base

  	# validates :role_id, presence: true
	belongs_to :staff
	belongs_to :role

	acts_as_enum :is_department, :in => [
	  ['de_no', -1, '否'],
	  ['de_yes', 1, '是']
	]

	acts_as_enum :is_warehouse, :in => [
	  ['wa_no', -1, '否'],
	  ['wa_yes', 1, '是']
	]

end