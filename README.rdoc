# PostallyAddressable (Beta)

PostallyAddressable lets you add postal addresses to your models. The postal addresses are all saved in one place using polymorphism, so you don't have to create additional columns when tracking a new model's address. You also have the ability to save the latitude, longitude, and time zone to the postal address if your application requires that data. PostallyAddressable still requires proper documentation and tests.

## Todo

 * Documentation (usage and caveats)
 * Tests

## Compatibility

Works with `ActiveRecord` 3+.

## Installation

### Rails 3 & 4

1. Add PostallyAddressable to your `Gemfile`.

    `gem 'postally_addressable', :git => 'git://github.com/mariusz360/postally_addressable.git'

2. Generate a migration which will add a `postal_addresses` table to your database.

    `bundle exec rails generate postally_addressable:install`

3. Run the migration.

    `bundle exec rake db:migrate`

4. Add `has_postal_address` to your models.

## Usage

``ruby
class User < ActiveRecord::Base
  has_postal_address
end
```

``ruby
>> user = User.new         # initializes user, then initializes postal address
>> user.postal_address     # #<PostalAddress id: nil, ...>

# Set the user's address
>> user.address_line_1 = "123 Mission St"

# Set the user's apt/suite/building
>> user.address_line_2 = "Apt 2"

# Set the user's locality
>> user.locality = "San Francisco"

# you can use city in place of locality
>> user.city               # "San Francisco"

# you can use state and province interchangeably
>> user.state = "California"
>> user.province           # "California"

# set the postal code
>> user.postal_code = "94105"

# check that an attribute isn't empty
>> user.country?           # false
>> user.country = "USA"
>> user.country?           # true

# saving the time zone is sometimes very useful
>> user.time_zone_name = "Pacific Time (US & Canada)"

# save user
>> user.save               # autosaves postal address
>> user.postal_address.id  # 1

# get the user's complete mailing address
>> user.mailing_address    # "123 Mission St Apt 2, San Francisco California 94105, USA"

# if you need the geocoordinates, you can save them to the postal address as well
# the following example uses the Geocoder gem
>> geocoded_result = Geocoder.search(user.mailing_address).first
>> user.update(latitude: geocoded_result.latitude, longitude: geocoded_result.latitude)
```


