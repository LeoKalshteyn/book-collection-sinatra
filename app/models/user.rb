class User < ActiveRecord::Base
  has_secure_password
  # one-to-many association with books
  has_many :books
end
