require 'test_helper'

class PostallyAddressableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PostallyAddressable
  end

  test 'version' do
    assert PostallyAddressable.const_defined?(:VERSION)
  end

  test 'created if postally_addressable created' do
    user = User.create
    assert user.postal_address.id?
  end

  test 'updated if postally_addressable created' do
    user = User.create
    assert user.postal_address.id?
    user.update_attributes(:address_line_1 => "123 Mission St")
    assert_equal "123 Mission St", user.postal_address.address_line_1
  end

  test 'destroyed if postally_addressable destroyed' do
    user = User.create
    assert user.postal_address.id?
    user.destroy
    assert user.postal_address.destroyed?
  end
end
