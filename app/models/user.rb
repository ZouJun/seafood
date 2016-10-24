class User < ActiveRecord::Base

  establish_connection 'masterkong_development'

  has_many :orders
end