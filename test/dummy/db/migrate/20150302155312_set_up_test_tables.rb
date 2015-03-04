class SetUpTestTables < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string   :name
      t.string   :email
    end

    create_table :rentals, :force => true do |t|
      t.integer  :user_id
      t.string   :title
    end

    add_index :rentals, [:user_id], name: :index_rental_on_user_id, using: :btree
    
    create_table :postal_addresses, force: :cascade do |t|
      t.integer  :postally_addressable_id
      t.string   :postally_addressable_type
      t.string   :address_line_1
      t.string   :address_line_2
      t.string   :locality
      t.string   :province
      t.string   :postal_code
      t.string   :country
      t.decimal  :latitude
      t.decimal  :longitude
      t.string   :time_zone_name
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :postal_addresses, [:postally_addressable_id, :postally_addressable_type], name: :index_postal_address_on_postally_addressable, unique: true, using: :btree
    add_index :postal_addresses, [:postally_addressable_type], name: :index_postal_address_on_postally_addressable_type, using: :btree
  end

  def self.down
    drop_table :postal_addresses
    drop_table :rentals
    drop_table :users
  end
end