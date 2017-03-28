class StaffTransfer < ActiveRecord::Base

	belongs_to :staff

  acts_as_enum :is_department, :in => [
      ['de_no', -1, '否'],
      ['de_yes', 1, '是']
  ]

  acts_as_enum :is_warehouse, :in => [
      ['wa_no', -1, '否'],
      ['wa_yes', 1, '是']
  ]

end