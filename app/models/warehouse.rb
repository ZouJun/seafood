class Warehouse < ActiveRecord::Base

	belongs_to :province
	belongs_to :city
	belongs_to :district

  has_many :warehouse_products
  has_many :warehouse_records
  has_many :system_records, as: :operatorable

	acts_as_enum :size, :in => [
	  ['small', 1, '小型'],
      ['medium', 2, '中型'],
      ['big', 3, '大型']
  	]

    acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  	]
end