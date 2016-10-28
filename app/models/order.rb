class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :agent
  belongs_to :dispatcher
  belongs_to :category
  paginates_per 5
  acts_as_enum :admin_status, :in => [
      ['admin_unassigned', 1, '未分配'],
      ['admin_assigned', 2, '已分配'],
      ['admin_cancel', -1, '放弃服务']
  ]

  acts_as_enum :agent_status, :in => [
      ['agent_unassigned', 1, '未分配'],
      ['agent_assigned', 2, '已分配'],
      ['agent_cancel', -1, '放弃服务']
  ]

  acts_as_enum :admin_allocation_type, :in => [
      ['admin_non_auto', 1, '人工分配'],
      ['admin_auto', 2, '自动分配'],
  ]

  acts_as_enum :agent_allocation_type, :in => [
      ['agent_non_auto', 1, '人工分配'],
      ['agent_auto', 2, '自动分配'],
  ]
end