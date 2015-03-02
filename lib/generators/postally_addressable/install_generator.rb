require 'rails/generators'
require 'rails/generators/active_record'

module PostallyAddressable
  class InstallGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      add_postally_addressable_migration('create_postal_addresses')
    end

    def self.next_migration_number(directory_name)
      ::ActiveRecord::Generators::Base.next_migration_number(directory_name)
    end

    protected
    def add_postally_addressable_migration(template)
      migration_directory = File.expand_path('db/migrate')
      if !self.class.migration_exists?(migration_directory, template)
        migration_template "#{template}.rb", "db/migrate/#{template}.rb"
      end
    end
  end
end
