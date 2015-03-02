module PostallyAddressable
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_postal_address(options = {})
        send :include, InstanceMethods

        has_one :postal_address, :as => :postally_addressable, :autosave => true

        after_initialize :find_or_initialize_postal_address

        # getters
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| a.to_sym }, to: :postal_address

        # setters
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| (a + "=").to_sym }, to: :postal_address

        # query methods
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| (a + "?").to_sym }, to: :postal_address

        # methods
        delegate *PostalAddress::DELEGATABLE_METHODS.map{ |m| m.to_sym }, to: :postal_address

        # methods- prefixed with "postal_address_"
        delegate *PostalAddress::PREFIXED_DELEGATABLE_METHODS.map{ |m| m.to_sym }, to: :postal_address, prefix: true

        def postal_addresses
          PostalAddress.of_type(model_name.name)
        end
      end
    end

    module InstanceMethods
      def find_or_initialize_postal_address
        self.postal_address ||= PostalAddress.new({
          postally_addressable: self
        })
      end

      def initialize(*args)
        super {}
        if args[0]
          self.attributes = args[0]
        end
      end
    end
  
  end
end
