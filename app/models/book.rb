class Book < ActiveRecord::Base
  # one-to-one association with user
  belongs_to :user
end
