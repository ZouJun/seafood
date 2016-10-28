class Dispatcher < ActiveRecord::Base
  has_secure_password
  belongs_to :agent
  has_many :orders
  paginates_per 10
  def self.authenticated(login, password)
    where("lower(login) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
  end

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  ]

end