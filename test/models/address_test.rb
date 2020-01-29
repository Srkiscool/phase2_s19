require 'test_helper'

class AddressTest < ActiveSupport::TestCase
	should belong_to (:customer)
	should have_many (:orders)





	should validate_presence_of(:recipient)
	should validate_presence_of(:street_1)
	should validate_presence_of(:zip)

# Validating zip...
  should allow_value("03431").for(:zip)
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)
  
  should_not allow_value("fred").for(:zip)
  should_not allow_value("3431").for(:zip)
  should_not allow_value("15213-9843").for(:zip)
  should_not allow_value("15d32").for(:zip)






	context "Given context" do
    # create the objects I want with factories
    setup do 
      create_customers
      create_addresses
      
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_addresses
      destroy_customers
      
    end

	should "identify a non-active order as invalid" do      
      address_with_inactive_customer = FactoryBot.build(:address, recipient: 'Aditya', active: false, zip: '20172', state: 'NH', customer: @bob)
      address_with_inactive_customer.save
      assert_equal false, address_with_inactive_customer.valid?
    end

# test the scope 'active'
     should "shows that there are two active Addresses" do
      assert_equal 2, Address.active.size
      assert_equal [@addy1,@addy3], Address.active 
      #assert_equal ["Alex", "Mark"], Address.active.map{|o| o.first_name}.sort
    end
    # test the scope 'inactive'
    should "shows that there is one inactive Address" do
      assert_equal 1, Address.inactive.size
      assert_equal [@addy2], Address.inactive
    end
    # test the scope 'by_recipient'
    should "Shows results ordered by recipient" do
    assert_equal [@addy2, @addy3, @addy1], Address.by_recipient

    end
    # test the scope 'by_customer'
    should "shows that there are three in by_customer order" do
    assert_equal [@addy2, @addy3, @addy1], Address.by_customer
    end

    #testing the scope "shipping"
    should "shows that there is 1 addy which are just shipping addresses" do
    assert_equal [@addy2, @addy3], Address.shipping
    end

    #testing scope "billing"
    should "shows that there are 2 addy which are billing addresses" do
    assert_equal [@addy1], Address.billing
    end

    #testing duplicates"
    should "not allow duplicate addresses" do
      dup1 = FactoryBot.build(:address, recipient: 'Venkata', active: true, customer: @sruthi, is_billing: true)
      assert_equal false, dup1.valid?
    end

    #MAKES CASES FOR ALREADY_exists

    # test the method "already_exists"
    # should "have a scope already_exists that works" do
    #   assert_equal true, Address.already_exists?(@addy1)
    #  end






  # test "the truth" do
  #   assert true
  # end
  end
end
