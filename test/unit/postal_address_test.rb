require 'test_helper'

class PostalAddressTest < ActiveSupport::TestCase
  setup do
    @postal_address = PostalAddress.create({
      address_line_1: "123 Mission St",
      address_line_2: "Apt 2",
      locality: "San Francisco",
      province: "CA",
      postal_code: "94105",
      country: "USA"
    })
  end

  context "mailing_address" do
    should "be properly formatted" do
      assert_equal "123 Mission St Apt 2, San Francisco CA 94105, USA", @postal_address.mailing_address
    end
  end

  context "DELEGATABLE_ATTRIBUTES" do
    should "include proper attributes" do
      %w(
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
      ).each do |delegatable_attribute|
        assert_includes(PostalAddress::DELEGATABLE_ATTRIBUTES, delegatable_attribute)
      end
    end
  end

  context "DELEGATABLE_METHODS" do
    should "include proper methods" do
      %w(
        mailing_address
      ).each do |delegatable_method|
        assert_includes(PostalAddress::DELEGATABLE_METHODS, delegatable_method)
      end
    end
  end

  context "PREFIXED_DELEGATABLE_METHODS" do
    should "include proper methods" do
      %w(
        changed?
        attributes
      ).each do |delegatable_prefixed_method|
        assert_includes(PostalAddress::PREFIXED_DELEGATABLE_METHODS, delegatable_prefixed_method)
      end
    end
  end

  context "city" do
    should "read locality attribute" do
      assert_equal "San Francisco", @postal_address.city
    end

    should "set locality attribute" do
      @postal_address.city = "Los Angeles"
      assert_equal "Los Angeles", @postal_address.locality
    end

    should "read locality query method" do
      assert @postal_address.city?
    end
  end

  context "state" do
    should "alias province attribute" do
      assert_equal "CA", @postal_address.state
    end

    should "set province attribute" do
      @postal_address.state = "TX"
      assert_equal "TX", @postal_address.province
    end

    should "read province query method" do
      assert @postal_address.state?
    end
  end

  context "of_type" do
    should "have records to choose from" do
      create_user_and_rental
      assert_not_equal 0, PostalAddress.of_type("User").count
    end

    should "narrow results by postally_addressable_type" do
      create_user_and_rental
      PostalAddress.of_type("User").each do |user|
        assert_equal "User", user.postally_addressable_type
      end
    end
  end

  def create_user_and_rental
    @user = User.create({
      name: "Mariusz",
      address_line_1: "123 Main St",
      address_line_2: "Apt 1"
    })
    @rental = Rental.create({
      title: "Don't miss out on this deal!",
      user: @user,
      address_line_1: "123 Main St",
      address_line_2: "Apt 4"
    })
  end

end