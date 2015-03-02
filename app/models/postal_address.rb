class PostalAddress < ActiveRecord::Base
  ##
   # Setters, getters, and query methods for these attributes are 
   # accessible from the postally_addressable object
   #
  DELEGATABLE_ATTRIBUTES = %w(
    address_line_1
    address_line_2
    locality
    city
    province
    state
    postal_code
    country
    time_zone_name
    latitude
    longitude
  )

  ##
   # These methods are accessible from the postally_addressable object
   #
  DELEGATABLE_METHODS = %w(
    mailing_address
  )
  # Same, but with the "postal_address_" prefix
  PREFIXED_DELEGATABLE_METHODS = %w(
    changed?
    attributes
  ) # e.g. obj.postal_address_changed?

  alias_attribute :city, :locality
  alias_attribute :state, :province

  belongs_to :postally_addressable, :polymorphic => true

  scope :of_type, ->(type) { where(postally_addressable_type: type) }

  def mailing_address
    mailing_address = "#{address_line_1}"
    mailing_address << " #{address_line_2}" if address_line_2?
    mailing_address << ", #{locality}" if locality?
    mailing_address << " #{province}" if province?
    mailing_address << " #{postal_code}" if postal_code?
    mailing_address << ", #{country}" if country?
    mailing_address.gsub(/\s+/, " ").strip
  end

end