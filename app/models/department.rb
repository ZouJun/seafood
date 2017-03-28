class Department < ActiveRecord::Base

	has_many :staffs
	has_many :system_records, as: :operatorable

	acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '禁用']
  	]
	
end