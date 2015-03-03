class Rental < ActiveRecord::Base
  belongs_to :user

  has_postal_address
  
end