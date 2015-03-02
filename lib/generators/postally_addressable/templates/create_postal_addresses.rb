class CreatePostalAddresses < ActiveRecord::Migration
  def change
    create_table :postal_addresses do |t|
      t.integer :postally_addressable_id
      t.string  :postally_addressable_type
      t.string  :address_line_1
      t.string  :address_line_2
      t.string  :locality
      t.string  :province
      t.string  :postal_code
      t.string  :country
      t.decimal :latitude
      t.decimal :longitude
      t.string  :time_zone_name

      t.timestamps
    end

    add_index :postal_addresses, [:postally_addressable_type], name: :index_postal_address_on_postally_addressable_type
    add_index :postal_addresses, [:postally_addressable_id, :postally_addressable_type], unique: true, name: :index_postal_address_on_postally_addressable
  end
end
