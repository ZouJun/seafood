class Agent < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :dispatchers
  paginates_per 10
  def self.authenticated(login, password)
    where("lower(login) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
  end

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  ]

  acts_as_enum :proxy_type, :in => [
      ['life', 1, '生活类'],
      ['service', 2, '服务类']
  ]
end