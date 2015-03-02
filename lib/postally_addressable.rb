# Require core library
require "postally_addressable/version"
require "postally_addressable/engine"
require "postally_addressable/has_postal_address"

module PostallyAddressable
  class << self
  end
end

ActiveRecord::Base.send :include, PostallyAddressable::Model
