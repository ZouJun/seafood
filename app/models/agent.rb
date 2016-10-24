class Agent < ActiveRecord::Base
  has_secure_password
  has_many :orders

  def self.authenticated(login, password)
    where("lower(login) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
  end

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disable', -1, '冻结']
  ]
end