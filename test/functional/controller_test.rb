require 'test_helper'

class ControllerTest < ActionController::TestCase
  tests UsersController

  test 'create' do
    post :create, :user => { :name => 'Mariusz', :email => 'mariusz@example.com', :address_line_1 => '123 Mission St' }
    user = assigns(:user)
    postal_address = user.postal_address
    assert_equal user.id?
    assert_equal postal_address.id?
    assert_equal '123 Mission St', postal_address.address_line_1
  end

  test 'update' do
    create_user_with_postal_address
    put :update, :id => @user.id, :user => { :name => 'New Name', :address_line_1 => '1111 Clay St', :address_line_2 => 'Apt 3' }
    user = assigns(:user)
    assert_equal 'New Name', user.name
    assert_equal '1111 Clay St', user.address_line_1
    assert_equal 'Apt 3', user.address_line_2
  end

  test 'destroy' do
    create_user_with_postal_address
    delete :destroy, :id => @user.id
    assert_equal false, User.exists?(id: @user.id)
    assert_equal false, PostalAddress.exists?(id: @postal_address.id)
  end

  def create_user_with_postal_address
    @user = User.create({
      :name => 'Mariusz', 
      :email => "mariusz@example.com", 
      :address_line_1 => "123 Mission St"
    })
    @postal_address = @user.postal_address
  end

end