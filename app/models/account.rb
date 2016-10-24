class Account < ActiveRecord::Base
  has_secure_password

  def self.authenticated(login, password)
    where("lower(login) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
  end
end