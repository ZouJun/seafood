class Category < ActiveRecord::Base

  has_many :orders

  acts_as_enum :category_type, :in => [
      ['life', 1, '生活类'],
      ['service', 2, '服务类']
  ]

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '不可用']
  ]

end