class User < ActiveRecord::Base
  # ActiveRecord macro which provides methods like authenticate
  has_secure_password
  # one-to-many association with books
  has_many :books
end
