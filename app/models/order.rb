class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :agent
  belongs_to :category

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['shield', -1, '屏蔽'],
      ['assigned', 2, '已分配'],
      ['unassigned', 3, '未分配']
  ]
end