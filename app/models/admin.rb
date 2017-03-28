class Admin < ActiveRecord::Base
  has_secure_password

  acts_as_enum :gender, :in => [
	  ['secert', 0, '保密'],
      ['male', 1, '男'],
      ['female', 2, '女']
  ]

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  ]

  def self.authenticated(login, password)
    where("lower(login) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
  end

end