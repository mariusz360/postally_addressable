module PostallyAddressable
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_postal_address(options = {})
        # default options
        options = { 
          eager_load: true
        }.merge(options)

        if options[:eager_load]
          default_scope { includes(:postal_address) }
        end

        has_one :postal_address, as: :postally_addressable, autosave: true, dependent: :destroy
        
        # getters
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| a.to_sym }, to: :postal_address

        # setters
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| (a + "=").to_sym }, to: :postal_address

        # query methods
        delegate *PostalAddress::DELEGATABLE_ATTRIBUTES.map{ |a| (a + "?").to_sym }, to: :postal_address

        # methods
        delegate *PostalAddress::DELEGATABLE_METHODS.map{ |m| m.to_sym }, to: :postal_address

        # prefixed methods
        delegate *PostalAddress::PREFIXED_DELEGATABLE_METHODS.map{ |m| m.to_sym }, to: :postal_address, prefix: true

        send :include, InstanceMethods
      end
    end

    module InstanceMethods

      def postal_address
        return super if super
        self.postal_address = PostalAddress.new({
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
