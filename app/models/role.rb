class Role < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :role_permission_maps
  has_many :staffs
  has_many :staff_transfers
  has_many :system_records, as: :operatorable
  
  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  ]
end