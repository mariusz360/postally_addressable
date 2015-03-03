class User < ActiveRecord::Base
  has_many :rentals

  has_postal_address
  
end